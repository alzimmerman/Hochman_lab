% From Michael Sorenson

function OUT = readabf(filename, varargin);
%
%READABF Read binary data out of Axon Instrument's .abf file format
%   S = readabf(FILENAME) opens the file specified in the string
%   FILENAME, and reads all relevant information
%   out into the Structure S.
%
%   S contains three primary fields:              
%      
%      header:  File variables pulled from the header of the .abf
%      file, including section pointers, channel names, etc.  
%
%      data:  Data from the file as determined by the header
%      information, data is stored with the variable name given by
%      the header variable sADCChannelName or sDACChannelName as
%      appropriate.  A vector called time stores time values for
%      the run based on the sample size provided in the header.
%      Finally, the units of measurement corresponding to the data
%      vectors are stored as strings under the units subsection.
%
%      waveform:  Any control waveform (i.e. for voltage clamping)
%      that was used in the experiment.
%
%   S = readabf(FILENAME, [t1 t2]) will return data in the time
%   range t1 to t2 (in seconds).
%   
%   S = readabf(FILENAME, f), where f is a single scalar, we read
%   the data at a time frequency of f Hertz.
%
%   S = readabf(FILENAME, [t1 t2], f) will return data in the 
%   specified time range at a frequency of f Hertz.
%
%   See also: ABFStruct

%   This program may be freely modified and distrubuted as long as
%   it is for a non-commercial purpose, and that the author,
%   Michael Sorensen (gte786r@prism.gatech.edu) is given credit.

%--------------------------------------------------------------------
%Process arguments and set defaults
%--------------------------------------------------------------------

READ_ENTIRE_FILE = 1;
MAX_NUMBER_SAMPLES = 1000000;

switch nargin
 case 2
  if length(varargin{1}) == 1,
    SAMPLE_ALT_FREQUENCY = varargin{1};
  elseif length(varargin{1}) == 2,
    READ_ENTIRE_FILE = 0;
    TIMERANGE = varargin{1};
    startDataTime = TIMERANGE(1);
    endDataTime = TIMERANGE(end);
  end
 case 3
  READ_ENTIRE_FILE = 0;
  TIMERANGE = varargin{1};
  startDataTime = TIMERANGE(1);
  endDataTime = TIMERANGE(end);
  SAMPLE_ALT_FREQUENCY = varargin{2};
end


FID = fopen(filename,'r','ieee-le');
%--------------------------------------------------------------------
%--------------------------------------------------------------------
% Header Information
%  
%  The purpose of this section is to read in all the relevant (and
%  possibly not-so-relevant) information from the header of the file.
%  I've followed the naming convention  (in most cases) for
%  variables given in Axon's documentation of the ABF file format.
%  Whenever I deviate from this, I'll let you know (e.g. the
%  section pointers in the File Structure section).
%--------------------------------------------------------------------
%--------------------------------------------------------------------

%--------------------------------------------------------------------
% Header Information - File ID and Size Info
%        
%    These 12 entries represent two types
%    of information: (1) File identification information; (2)
%    Parameters whose actual values may be different to the values
%    requested before the acquisition commenced, e.g. due to a user
%    abort. The requested values are located elsewhere.
%--------------------------------------------------------------------

fseek(FID,0,-1);
ABFFile.header.fileInfo.IFileSignature = char(fread(FID,4,'schar'))';
ABFFile.header.fileInfo.fFileVersionNumber = fread(FID, 1, 'single');
ABFFile.header.fileInfo.nOperationMode = fread(FID,1, 'int16');
ABFFile.header.fileInfo.IActualAcqLength = fread(FID,1,'int32');
ABFFile.header.fileInfo.nNumPointsIgnored = fread(FID,1,'int16');
ABFFile.header.fileInfo.IActualEpisodes = fread(FID, 1, 'int32');
ABFFile.header.fileInfo.IFileStartDate = fread(FID, 1, 'int32');
ABFFile.header.fileInfo.IFileStartTime = fread(FID, 1, 'int32');
ABFFile.header.fileInfo.IStopwatchTime = fread(FID, 1, 'int32');
ABFFile.header.fileInfo.fHeaderVersionNumber = fread(FID, 1, 'float');
ABFFile.header.fileInfo.nFileType  = fread(FID, 1, 'int16');
ABFFile.header.fileInfo.nMSBinFormat  = fread(FID, 1, 'int16');

%--------------------------------------------------------------------
% Header Information - File Structure
%
%  Thirteen entries describing the structure of the file.  The most
%  important entries here are the section pointers, which point to
%  the starting block of the various sections (each block is 512
%  bytes long).  All the pointers are stored in a single vector, to
%  help determine the order of the sections, since this can vary
%  from file-to-file.  The header starts at block zero, if a
%  section pointer for a non-header section is given as zero, it
%  means that section was not relevant (i.e., there is no Voice
%  Tags section, or something like that.
%--------------------------------------------------------------------

fseek(FID,40,-1);
%Data Section 
ABFFile.header.fileInfo.IDataSectionPtr = fread(FID, 1, 'int32');

%Tags Section
ABFFile.header.fileInfo.ITagSectionPtr = fread(FID, 1, 'int32');
ABFFile.header.fileInfo.INumtagEntries = fread(FID, 1, 'int32');

%Scope Config Section 
ABFFile.header.fileInfo.IScopeConfigPtr = fread(FID, 1, 'int32');
ABFFile.header.fileInfo.INumScopes = fread(FID, 1, 'int32');

%skip over outdated and unused info
%!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
%need to modify here to take advantage of old files?
%!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
fseek(FID, 72, -1);

%Delta Array Section 
ABFFile.header.fileInfo.IDeltaArrayPtr = fread(FID, 1, 'int32');
ABFFile.header.fileInfo.INumDeltas = fread(FID,1,'int32');

%Voice Tag Section
ABFFile.header.fileInfo.IVoiceTagPtr = fread(FID, 1, 'int32');
ABFFile.header.fileInfo.IVoiceTagEntries = fread(FID, 2, 'int32');

%Synch Array Section
%there is an unused long between voice tag & synch array
fseek(FID, 92, -1);
ABFFile.header.fileInfo.ISynchArrayPtr = fread(FID, 1, 'int32');
ABFFile.header.fileInfo.ISynchArraySize = fread(FID, 1, 'int32');

ABFFile.header.fileInfo.nDataFormat = fread(FID, 1, 'int16');
ABFFile.header.fileInfo.sSimultaneousScan = fread(FID, 1, 'int16');

%Pointer to DAC Section
%!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
%need to modify to take into account old versions
%!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
if ABFFile.header.fileInfo.fFileVersionNumber >= 1.6
  fseek(FID,2048,-1);
  ABFFile.header.fileInfo.IDACFilePtr = fread(FID, 1, 'int32');
  ABFFile.header.fileInfo.IDACFileNumEpisodes = fread(FID,1,'int32');
end

%-------------------------------------------------------------------
% Header Information - Trial Hierarchy Information
%
%   24 Entries describing the trial hierarchy.
%-------------------------------------------------------------------

fseek(FID, 120, -1);

ABFFile.header.trialInfo.nADCNumChannels = fread(FID, 1, 'int16');
ABFFile.header.trialInfo.fADCSampleInterval = fread(FID, 1, 'float32');
ABFFile.header.trialInfo.fADCSecondSampleInterval = fread(FID, 1, 'float32');
ABFFile.header.trialInfo.fSynchTimeUnit = fread(FID, 1, 'float32');
ABFFile.header.trialInfo.fSecondsPerRun = fread(FID, 1, 'float32');
ABFFile.header.trialInfo.INumSamplesPerEpisode = fread(FID, 1, 'int32');
ABFFile.header.trialInfo.IPreTriggerSamples = fread(FID, 1, 'int32');
ABFFile.header.trialInfo.IEpisodesPerRun = fread(FID, 1, 'int32');
ABFFile.header.trialInfo.IRunsPerTrial = fread(FID, 1, 'int32');
ABFFile.header.trialInfo.INumberOfTrials = fread(FID, 1, 'int32');
ABFFile.header.trialInfo.nAveragingMode = fread(FID, 1, 'int16');
ABFFile.header.trialInfo.nUndoRunCount = fread(FID, 1, 'int16');
ABFFile.header.trialInfo.nFirstEpisodeInRun = fread(FID, 1, 'int16');
ABFFile.header.trialInfo.fTriggerThreshold = fread(FID, 1, 'float32');
ABFFile.header.trialInfo.nTriggerSource = fread(FID, 1, 'int16');
ABFFile.header.trialInfo.nTriggerAction = fread(FID, 1, 'int16');
ABFFile.header.trialInfo.nTriggerPolarity = fread(FID, 1, 'int16');
ABFFile.header.trialInfo.fScopeOutputInterval = fread(FID, 1,'float32');
ABFFile.header.trialInfo.fEpisodeStartToStart = fread(FID, 1,'float32');
ABFFile.header.trialInfo.fRunStartToStart = fread(FID, 1, 'float32');
ABFFile.header.trialInfo.fTrialStartToStart = fread(FID, 1, 'float32');
ABFFile.header.trialInfo.IAverageCount = fread(FID, 1,'int32');
ABFFile.header.trialInfo.IClockChange = fread(FID, 1,'int32');
ABFFile.header.trialInfo.nAutoTriggerStrategy = fread(FID, 1,'int16');

%-------------------------------------------------------------------
%  Header Information - Display Parameters
%    Header entries describing display options in effect during
%    acquisition.
%-------------------------------------------------------------------

%-------------------------------------------------------------------
%  Header Information - Hardware Information
%-------------------------------------------------------------------
fseek(FID,244,-1);
ABFFile.header.hardwareInfo.fADCRange = fread(FID, 1, 'float32');
ABFFile.header.hardwareInfo.fDACRange = fread(FID, 1, 'float32');
ABFFile.header.hardwareInfo.IADCResolution = fread(FID, 1, 'int32');
ABFFile.header.hardwareInfo.IDACResolution = fread(FID, 1, 'int32');
%-------------------------------------------------------------------
%  Header Information - Environmental Information
%-------------------------------------------------------------------

%-------------------------------------------------------------------
%  Header Information - Multi-channel Information
%-------------------------------------------------------------------
fseek(FID, 378, -1);
ABFFile.header.channelInfo.nADCPtoLChannelMap = fread(FID,16, 'int16');
ABFFile.header.channelInfo.nADCSamplingSeq = fread(FID, 16, 'int16');

%We place names of channels, etc. into cell arrays
tmp = fread(FID,160,'schar');
ABFFile.header.channelInfo.sADCChannelName = cellstr(char(tmp(reshape(1:160,10, ...
						  16)')));
tmp = fread(FID, 128, 'schar');
ABFFile.header.channelInfo.sADCUnits = cellstr(char(tmp(reshape(1:128,8,16)')));

ABFFile.header.channelInfo.fADCProgrammableGain = fread(FID, 16, 'float32');
ABFFile.header.channelInfo.fADCDisplayAmplification = fread(FID, 16, 'float32');
ABFFile.header.channelInfo.fADCDisplayOffset = fread(FID, 16, 'float32');
ABFFile.header.channelInfo.fInstrumentScaleFactor = fread(FID, 16, 'float32');
ABFFile.header.channelInfo.fInstrumentOffset = fread(FID, 16, 'float32');
ABFFile.header.channelInfo.fSignalGain = fread(FID, 16, 'float32');
ABFFile.header.channelInfo.fSignalOffset = fread(FID, 16, 'float32');
ABFFile.header.channelInfo.fSignalLowpassFilter = fread(FID, 16, 'float32');
ABFFile.header.channelInfo.fSignalHighpassFilter = fread(FID, 16, 'float32');

tmp = fread(FID,40,'schar');
ABFFile.header.channelInfo.sDACChannelName = cellstr(char(tmp(reshape(1:40,10,4)')));

tmp = fread(FID,32,'schar');
ABFFile.header.channelInfo.sDACChannelUnits = cellstr(char(tmp(reshape(1:32,8,4)')));;
ABFFile.header.channelInfo.fDACScaleFactor = fread(FID, 4, 'float32');
ABFFile.header.channelInfo.fDACHoldingLevel = fread(FID, 4, 'float32');
ABFFile.header.channelInfo.nSignalType = fread(FID, 1, 'int16');

%-------------------------------------------------------------------
%  Header Information - Synchronous Timer Outputs
%-------------------------------------------------------------------

%-------------------------------------------------------------------
%  Header Information - Epoch Waveform and Pulses
%-------------------------------------------------------------------
fseek(FID, 1436, -1);
ABFFile.header.waveformInfo.nDigitalEnable = fread(FID, 1, ...
						  'int16');
fseek(FID, 1440, -1);
ABFFile.header.waveformInfo.nActiveDACChannel = fread(FID,1, ...
						  'int16');
fseek(FID, 1584, -1);
ABFFile.header.waveformInfo.nDigitalHolding = fread(FID,1,'int16');
ABFFile.header.waveformInfo.nDigitalInterEpisode = fread(FID,1, ...
						  'int16');
ABFFile.header.waveformInfo.nDigitalValue = fread(FID,10,'int16');

if ABFFile.header.fileInfo.fFileVersionNumber >= 1.6
  fseek(FID,2296,-1);
  ABFFile.header.waveformInfo.nWaveformEnable = fread(FID, 2, ...
						  'int16');
  ABFFile.header.waveformInfo.nWaveformSource = fread(FID, 2, ...
						  'int16');
  ABFFile.header.waveformInfo.nInterEpisodeLevel = fread(FID,2, ...
						  'int16');
  %the following values are stored in columns, column one
  %corresponding to analog output 0, and column two corresponding
  %to analog output 1.  The rows correspond to...
  
  ABFFile.header.waveformInfo.nEpochType(:,1) = fread(FID, 10, ...
						  'int16');
  ABFFile.header.waveformInfo.nEpochType(:,2) = fread(FID, 10, ...
						  'int16');
  ABFFile.header.waveformInfo.fEpochInitLevel(:,1) = fread(FID, 10, ...
						  'float32');
  ABFFile.header.waveformInfo.fEpochInitLevel(:,2) = fread(FID, 10, ...
						  'float32');
  ABFFile.header.waveformInfo.fEpochLevelInc(:,1) = fread(FID, 10, ...
						  'float32');
  ABFFile.header.waveformInfo.fEpochLevelInc(:,2) = fread(FID, 10, ...
						  'float32');
  ABFFile.header.waveformInfo.IEpochInitDuration(:,1) = fread(FID,10, ...
						  'int32');
  ABFFile.header.waveformInfo.IEpochInitDuration(:,2) = fread(FID,10, ...
						  'int32');
  ABFFile.header.waveformInfo.IEpochDurationInc(:,1) = fread(FID,10, ...
						  'int32');
  ABFFile.header.waveformInfo.IEpochDurationInc(:,2) = fread(FID,10, ...
						  'int32');
else
  fseek(FID,1438,-1);
  ABFFile.header.waveformInfo.nWaveformSource = fread(FID,1, ...
						  'int16');
  %nWaveformSource definition:
  %     0 = Disable
  %     1 = Generate from definitions
  %     2 = Generate from DAC file (see DAC Output File section)
  
  fseek(FID,1442,-1);
  ABFFile.header.waveformInfo.nInterEpisodeLevel = fread(FID,1, ...
						  'int16');
  %nInterEpisodeLevel definition:
  %     0 = Use holding level
  %     1 = Use last amplitude 
  
  ABFFile.header.waveformInfo.nEpochType = fread(FID, 10, 'int16');
  %nEpochType definition:
  %     0 = Disabled
  %     1 = Step
  %     2 = Ramp
  
  ABFFile.header.waveformInfo.fEpochInitLevel = fread(FID,10,'float32');
  ABFFile.header.waveformInfo.fEpochLevelInc = fread(FID,10,'float32');
  ABFFile.header.waveformInfo.nEpochInitDuration = fread(FID,10,'int16');
  ABFFile.header.waveformInfo.nEpochDurationInc = fread(FID,10,'int16');  
end

%-------------------------------------------------------------------
%  Header Information - DAC Output File
%-------------------------------------------------------------------

%-------------------------------------------------------------------
%  Header Information - Conditioning Pulse Train
%-------------------------------------------------------------------

%-------------------------------------------------------------------
%  Header Information - Variable Parameter User List
%-------------------------------------------------------------------

%-------------------------------------------------------------------
%  Header Information - Statistics Measurement
%-------------------------------------------------------------------

%-------------------------------------------------------------------
%  Header Information - Channel Arithmetic
%-------------------------------------------------------------------

%-------------------------------------------------------------------
%  Header Information - On-line Subtraction
%-------------------------------------------------------------------

%-------------------------------------------------------------------
%  Header Information - Unused Space at End of Header Block
%-------------------------------------------------------------------


%-------------------------------------------------------------------
%  Data
%    Read the trial data out of the .abf file.  First, we extract
%    all generally usefull information from the header, like Data
%    Section offset, trial length, etc.  With that in place, we
%    switch on the operation mode, since data is different for
%    different operation modes.  I'm still working on understanding
%    all the differences and implementing all five modes.
%-------------------------------------------------------------------

%First, extract the important Header variables into shorter names
%so we don't have to type so freaking much.

IActualAcqLength = ABFFile.header.fileInfo.IActualAcqLength;
nOperationMode = ABFFile.header.fileInfo.nOperationMode;
IDataSectionPtr = ABFFile.header.fileInfo.IDataSectionPtr;
INumSamplesPerEpisode = ABFFile.header.trialInfo.INumSamplesPerEpisode;
nADCNumChannels = ABFFile.header.trialInfo.nADCNumChannels;
IEpisodesPerRun = ABFFile.header.trialInfo.IEpisodesPerRun;
fADCSampleInterval = ABFFile.header.trialInfo.fADCSampleInterval;
fSecondsPerRun = ABFFile.header.trialInfo.fSecondsPerRun;
nADCSamplingSeq = ABFFile.header.channelInfo.nADCSamplingSeq;
sADCChannelName = ABFFile.header.channelInfo.sADCChannelName;
sADCUnits = ABFFile.header.channelInfo.sADCUnits;

%we're going to need to scale and offset our data
fADCRange = ABFFile.header.hardwareInfo.fADCRange;
fDACRange = ABFFile.header.hardwareInfo.fDACRange;
IADCResolution = ABFFile.header.hardwareInfo.IADCResolution;
IDACResolution = ABFFile.header.hardwareInfo.IDACResolution;
scaling = ABFFile.header.channelInfo.fADCProgrammableGain.* ...
	  ABFFile.header.channelInfo.fInstrumentScaleFactor.* ...
	  ABFFile.header.channelInfo.fSignalGain;

offset = ABFFile.header.channelInfo.fInstrumentOffset;

%Hi!  I'm aquiring 20 minutes of data at 10KHz, and I like to see
%matlab's leaky memory problems crash my machine.  Just kidding.
%What I REALY want to do is figure out if I'm going to overload my
%system, but I can't find a way to determine what the size of the
%swap space is from within Matlab.  So we'll define a limit for
%right now, givinig the user control to overload things if they're
%feeling suicidal.

MAX_NUMBER_SAMPLES = 1000000;
numSamples = IActualAcqLength/nADCNumChannels;
%determine the last time point, usefull if we're only reading a
%range of the data
ENDTIME = (numSamples -1)*fADCSampleInterval* ...
	  1e-6*nADCNumChannels;

if numSamples > MAX_NUMBER_SAMPLES & READ_ENTIRE_FILE == 1,

end

%We need to initialize Data or setfield will not work.
ABFFile.data = [];
ABFFile.data.units = [];

%We're reading the entire file at the recorded frequency, we need
%to determine the offset of the data section and the range that the
%data covers.  We take care of de-multiplexing later.
if READ_ENTIRE_FILE == 1 & ~exist('SAMPLE_ALT_FREQUENCY','var'),
  
  dataOffset = 512*IDataSectionPtr;
  fseek(FID, dataOffset, -1);
  data = fread(FID, IActualAcqLength, 'int16=>int16');
  fclose(FID);
  t = 0:(IActualAcqLength/nADCNumChannels -1);
  t = t*fADCSampleInterval*1e-6*nADCNumChannels;
  ABFFile.data = setfield(ABFFile.data, 'time', t);  

%Reading at a different frequency.  First we need to determine how
%many samples to skip at a time based upon the recorded frequency
%and our alternate frequency.  Then we need to read the data.
elseif READ_ENTIRE_FILE == 1 & exist('SAMPLE_ALT_FREQUENCY', ...
				     'var'),
  dataOffset = 512*IDataSectionPtr;
  fseek(FID, dataOffset, -1);
  
  sampleAltPeriod = (1/SAMPLE_ALT_FREQUENCY)/1e-6;
  recordedPeriod = fADCSampleInterval*nADCNumChannels;
  ratio = floor(sampleAltPeriod/recordedPeriod);
  
  bytesToSkip = (ratio-1)*2*nADCNumChannels;
  NumSamples = IActualAcqLength/nADCNumChannels;
  dataLength = floor(IActualAcqLength/ratio/nADCNumChannels)*nADCNumChannels;
  precision = strcat(num2str(nADCNumChannels), '*int16=>int16');
  
  data = fread(FID, dataLength, precision, bytesToSkip);
  fclose(FID);
  t = 0:(length(data)/nADCNumChannels-1);
  t = t*fADCSampleInterval*1e-6*nADCNumChannels*ratio;
  ABFFile.data = setfield(ABFFile.data, 'time', t);  

  %Reading just a range of data, need to determine special time
%vector and data offsets.
elseif READ_ENTIRE_FILE == 0 & ~exist('SAMPLE_ALT_FREQUENCY','var'),
  dataStartIndex = floor(startDataTime/ENDTIME*(IActualAcqLength/nADCNumChannels ...
		-1));
  dataEndIndex = ceil(endDataTime/ENDTIME*(IActualAcqLength/nADCNumChannels ...
		-1));
  
  t = 0:(IActualAcqLength/nADCNumChannels -1);
  t = t(dataStartIndex+1:dataEndIndex);
  t = t*fADCSampleInterval*1e-6*nADCNumChannels;
  ABFFile.data = setfield(ABFFile.data, 'time', t); 
  
  %read in multiplexed data from file.
  
  dataOffset = 512*IDataSectionPtr + dataStartIndex* ...
      nADCNumChannels*2;
  dataLength = length(t)*nADCNumChannels;
  fseek(FID, dataOffset, -1);
  data = int16(fread(FID, dataLength, 'int16'));
  fclose(FID);   
elseif READ_ENTIRE_FILE == 0 & exist('SAMPLE_ALT_FREQUENCY','var'),
  
  fclose(FID);   
end
  
%the method in which the data is stored is different for the
%different aquisition modes.

switch nOperationMode
%nOperationMode=1,Variable-Length Events.
%
% Currently not supported
%
%nOperationMode=2,Fixed-Length Events.
%
% Currently not supported
%
%nOperationMode=3, Gap-free recording.
%Samples are stored back to back, multiplexed across the number of
%channels recorded.  For example, if there are four channels being
%recorded (A,B,C,D) the data will be stored as A1, B1, C1, D1, A2,
%B2, C3, D2, A3, etc. Where A1 is the first sample of channel A, B2
%is the second sample of channel B, etc.  So once we read the data,
%all we need to do is de-multiplex it and store the results into
%appropriately named vectors.
 case 3
  %De-Multiplex the Data
  dataLength = length(data);
  
  for i = 1:nADCNumChannels,
    index = i:nADCNumChannels:dataLength;
    deMuxedData(:,i) = data(index);
  end
  
  %Things can get pretty memory-intensive with large files, let's
  %try our best not to run out of memory.
  clear data
  clear index
  
  %Scale the data so that it corresponds with its given units,
  %shift it by its given offsets, and
  %store in the ABFFile Structure.   
   for i = 1:nADCNumChannels,
     fieldName = char(sADCChannelName(nADCSamplingSeq(i)+1)); 
     fieldName = strrep(fieldName, ' ', '');
     dataSlice = double(deMuxedData(:,i))*fADCRange/IADCResolution/ ...
	 scaling(nADCSamplingSeq(i) + 1) + offset(nADCSamplingSeq(i)+1);
     ABFFile.data = setfield(ABFFile.data, fieldName, dataSlice');
     ABFFile.data.units = setfield(ABFFile.data.units, fieldName, ...
			char(sADCUnits(nADCSamplingSeq(i)+1)));
   end
   clear deMuxedData;

%nOperationMode=4, High-Speed Oscilloscope.   
%
% Currently not supported
%
%nOperationMode=5, Episodic Stimulation.   
%
%Episodic Stimulation is often used in voltage clamp protocols.
%With episodic stimulation, there are multiple episodes (also
%called sweeps by different versions of Clampex, and axon doesn't
%seem to be very consistant with using either one, so just
%remember, a SWEEP IS THE SAME AS AN EPISODE), often with
%some control parameter varying between sweeps.  An important thing
%to note is that if we have multiple runs through the episodes, only
%the average of the runs is saved.  So, we need to do two things in
%this case, de-multiplex the data, and sort the channels into
%vectors corresponding to each episode.

 case 5  
  %De-Multiplex the Data, creating Matrices for each channel, with
  %each sweep or averaged sweep running in a column.
  
  INumSweeps = length(data)/INumSamplesPerEpisode;
  
  for i = 1:INumSweeps,
    for j = 1:nADCNumChannels,
        try
            index = j:nADCNumChannels:INumSamplesPerEpisode;
            index = index + (i-1)*INumSamplesPerEpisode;
            deMuxedData(j,i,:) = data(index);
        catch
            OUT.header = ABFFile.header;
            OUT.datalength = length(data);
            OUT.Episodes = IEpisodesPerRun;
            OUT.nADCNumChannels = nADCNumChannels;
            OUT.ij = [i j];
            return
        end
    end
  end
  
  %Scale the data so that it corresponds with its given units, and
  %store in the ABFFile Structure.   
  for i = 1:nADCNumChannels,
    fieldName = regexprep(char(sADCChannelName(nADCSamplingSeq(i)+1)), '\s', '_'); 
    dataSlice = double(reshape(deMuxedData(i,:,:), INumSweeps, ...
			max(size(deMuxedData))));
    dataSlice = dataSlice*fADCRange/IADCResolution/ ...
	scaling(nADCSamplingSeq(i) + 1) + offset(nADCSamplingSeq(i)+1);
    ABFFile.data = setfield(ABFFile.data, fieldName, dataSlice');
    ABFFile.data.units = setfield(ABFFile.data.units, fieldName, ...
		char(sADCUnits(nADCSamplingSeq(i)+1)));
  end   
  clear deMuxedData;
  %Time is different here, need time only covering range of sweep.
  endTimeIndex = length(ABFFile.data.time)/INumSweeps;
  ABFFile.data.time = ABFFile.data.time(1:endTimeIndex);
 otherwise
end

%-------------------------------------------------------------------
%  Control
%     Description of control waveforms, currently just making plots
%     of whatever's on Analog Outputs 0 and 1, since I don't use
%     the Digital Outputs, but maybe I will in the future.  All the
%     important variables appear to be included in
%     header.waveFormInfo, so we just have to figure out what they
%     are and generate some vectors.
%
%     Also note, this is only valid for nOperationMode = 5, aka
%     Episodic Stimulation mode.
%-------------------------------------------------------------------
ABFFile.waveform = [];
if nOperationMode == 5,
  if ABFFile.header.fileInfo.fFileVersionNumber >= 1.6
    nEpochType = ABFFile.header.waveformInfo.nEpochType;
    fEpochInitLevel = ABFFile.header.waveformInfo.fEpochInitLevel;
    fEpochLevelInc = ABFFile.header.waveformInfo.fEpochLevelInc;
    IEpochInitDuration = ...
	ABFFile.header.waveformInfo.IEpochInitDuration;
    IEpochDurationInc = ...
	ABFFile.header.waveformInfo.IEpochDurationInc;
    for analogChannel = 1:2,
      if (ABFFile.header.waveformInfo.nWaveformSource(analogChannel) ...
	    == 1 & ...
	    ABFFile.header.waveformInfo.nWaveformEnable(analogChannel) ...
	    ~= 0),
	fieldName = regexprep(char(ABFFile.header.channelInfo ...
		 .sDACChannelName(analogChannel)), '\s', '_');	
	holdingTime = ...
	    floor(ABFFile.header.trialInfo.INumSamplesPerEpisode/ ...
		  64);
	ABFFile.header.waveformInfo.holdingTime = holdingTime;
	startLevel = ...
	      ABFFile.header.channelInfo ...
	      .fDACHoldingLevel(analogChannel);
	for i = 1:ABFFile.header.fileInfo.IActualEpisodes,
	  epochNumber = 1;
	  xpoints = [0 holdingTime];
	  ypoints = [startLevel startLevel];
	  while epochNumber <= 10 & nEpochType(epochNumber, analogChannel) ~=0,
	    xnext = xpoints(end) + IEpochInitDuration(epochNumber, ...
			analogChannel)+IEpochDurationInc(epochNumber, ...
						analogChannel)*(i-1);
	    ynext = fEpochInitLevel(epochNumber, ...
			analogChannel)+fEpochLevelInc(epochNumber, ...
						analogChannel)*(i-1);
	    if nEpochType(epochNumber, analogChannel) == 1,
	      xpoints = [xpoints xpoints(end) xnext];
	      ypoints = [ypoints ynext ynext];
	    elseif nEpochType(epochNumber, analogChannel) == 2,
	      xpoints = [xpoints xnext];
	      ypoints = [ypoints ynext];
	    end
	    epochNumber = epochNumber + 1;
	  end
	  if ABFFile.header.waveformInfo.nInterEpisodeLevel(analogChannel) ...
		== 0,
	    startLevel = ...
		ABFFile.header.channelInfo ...
		.fDACHoldingLevel(analogChannel);
	  else
	    startLevel = ypoints(end);
	  end
	  xpoints = [xpoints xpoints(end) ...
		       ABFFile.header.trialInfo.INumSamplesPerEpisode];
	  ypoints = [ypoints startLevel startLevel];
	  
	  xpointsFinal(:, i) = xpoints';
	  ypointsFinal(:, i) = ypoints';
	end

	ABFFile.waveform.xPoints = xpointsFinal;
	ABFFile.waveform.yPoints = ypointsFinal;
      end
    end
  else   
    disp('No waveform generation yet for ABF < 1.6, sorry...');
  end
end

OUT = ABFFile;
