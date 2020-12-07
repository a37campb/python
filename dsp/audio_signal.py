#audio signals for processing
import numpy as np 
import wave
import struct
import matplotlib.pyplot as plt 

f = 1000
samps = 48000
samp_rate = 48000.0
A = 16000
file = 'test.wav'
y = [np.sin(2*np.pi*f*i/samp_rate) for i in range(samps)]

nframes = samps
comptype = "NONE"
compname="not compressed"
nchannels=1
sampwidth=2
wav_file=wave.open(file, 'w')
wav_file.setparams((nchannels,sampwidth, int(samp_rate),nframes,comptype, compname))
for i in y: 
    wav_file.writeframes(struct.pack('h',int(i*A)))



frate = 48000.0
infile = 'test.wav'
wav_file_in = wave.open(infile, 'r')
data = wav_file_in.readframes(samps)
wav_file_in.close()
data = struct.unpack('{n}h'.format(n=samps),data)
data = np.array(data)
data_fft = np.fft.fft(data)
freqs = np.abs(data_fft)
plt.subplot(2,1,1)
plt.plot(data[:300])
plt.title('Original audio wave')
plt.subplot(2,1,2)
plt.plot(freqs)
plt.title('Frequencies found')
plt.xlim(0,1200)
plt.show()
