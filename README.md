# DroneSignalAnalysis
This repository contains MATLAB scripts  of the Drone Signal Dataset found in IEEE DataPort
The Initial scripts provided by the DataSet creators were for normal operation 
This script does a bunch of signal operations to get a bit more in-depth quantitative and qualitative analysis of the signals in questions
and uses MATLAB's built in <I>"gpuArray"</I> function and <I>"gather"</I> functions to move data from GPU to CPU for ease of analysis.
<H1><B>Scripts and Their Description</B></H1>
<H3><B><I>readDD.m</I></B></H3>
<p>This is a class definition file in our ecosystem which has the preliminary data handling, this code was heavily adopted and is a modified with the aid of the previous 
  <i>droneRC</i> code that was present in the authors pool of scripts.</p>
  <p>For this script the inputs are as follows</p>
  <p>readDD is a function class written to process data as GPU arrays</p>
  <p>Make: Drone Manufaturer</p>
  <p>Model: Drone Model</p>
  <p>Fs: Sampling rate provided from documentation</p>
  <p>Index: Sample Index number Recoreded from Sample</p>
  <p>NumSamples: Total samples recorded</p>
  <p>ScaleFactor: Amplitude Scaling factor due to point conversions</p>
  <p>Duration: NumSamples/Fs</p>
  <p>RawData: The data captured from the front end</p>
  <p>CroppedData: Time Applied Cropped Data to avoid Memory Issues</p>
 <p> Usage: declare fileName = 'path/to/file/filename/file'</p>
  <p>foo = readDD(fileName);</p>
  <p>foo</p>
  plotting of Raw and Cropped data can be directly called from the
  varialbe like the one given below<>
  <p>plot(foo.RawData)</p>
  <p>plot(foo.CroppedData)</p>
<b>Apart from this I have added 1 single sample of the signal which is around 7MB and has data in it's description</b>
