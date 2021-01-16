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
  <p>readDD(fileName, Fs)</p>
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
  <p>foo = readDD(fileName, Fs);</p>
  <p>foo</p>
  plotting of Raw and Cropped data can be directly called from the
  varialbe like the one given below<>
  <p>plot(foo.RawData)</p>
  <p>plot(foo.CroppedData)</p>
<b>Apart from this I have added 1 single sample of the signal which is around 7MB and has data in it's description</b>
<H3><B><I>window_expt.m</I></B></H3>
<p>I primed this file to primarily to understand about the windows that I can use in this case for my analysis
  .But at the end I decided to roll with <i>kaiser</i> window for now atleast</p>
<H3><B><I>procDD.m</I></B></H3>
<p>This file takes the GPU arrays and plots them down to the CPU and does a bunch signal statistics operations like <i>spectral enrtopy</i>, 
  <i>power spectrum</i>, <i>kurtosis</i>, <i>window optimization</i>. This script will be further expanded and modified in the due course of this thing</p>

<H1>TO DO</H1>
Create a wiki and move all the data there. Have only references here.

<H1>References and Ciatation</H1>
[1]. http://ieee-dataport.org/open-access/drone-remote-controller-rf-signal-dataset <br />
[2]. Martins Ezuma, Fatih Erden, Chethan K. Anjinappa, Ozgur Ozdemir, Ismail Guvenc, November 25, 2020, "Drone Remote Controller RF Signal Dataset", IEEE Dataport, doi: https://dx.doi.org/10.21227/ss99-8d56. <br />
[3]. M. Ezuma, F. Erden, C. Kumar, O. Ozdemir, and I. Guvenc, "Micro-UAV detection and classification from RF fingerprints using machine learning techniques," in Proc. IEEE Aerosp. Conf., Big Sky, MT, Mar. 2019, pp. 1-13. <br />
[4]. M. Ezuma, F. Erden, C. K. Anjinappa, O. Ozdemir, and I. Guvenc, "Detection and classification of UAVs using RF fingerprints in the presence of Wi-Fi and Bluetooth interference," IEEE Open J. Commun. Soc., vol. 1, no. 1, pp. 60-79, Nov. 2019. <br />
[5].E. Ozturk, F. Erden, and I. Guvenc, "RF-based low-SNR classification of UAVs using convolutional neural networks." arXiv preprint arXiv:2009.05519, Sept. 2020.
