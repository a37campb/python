#This file is to build a DSP windowed sinc function
from typing import List
import numpy as np 
import matplotlib.pyplot as plt

class filter():
    def __init__(self):
        return None 

    def __dft(self,inp:np.array):
        arr = np.array(inp,dtype=float)
        N = arr.shape[0]
        n = np.arange(N)
        k = n.reshape((N,1))
        M = np.exp(-2j * np.pi * k * n /N)
        return np.dot(M,arr)

    def __idft(self,inp_freq:np.array):
        return None

    def __fft(self, inp:np.array) -> List[float]:
        arr = np.array(inp)
        N = arr.shape[0]
        if N%2 != 0:
            raise ValueError("Must be a power of 2")
        elif N<=2:
            return filter.__dft(self, arr)
        else:
            even = filter.__fft(self, arr[::2])
            odd = filter.__fft(self, arr[1::2])
            terms = np.exp(-2j * np.pi * np.arange(N) / N)
        return np.concatenate([even + terms[:int(N/2)] * odd, even + terms[int(N/2):] * odd])

    def __ifft(self, inp:np.array) -> List[float]:
        return None
    
    def sign_flip(self, H:List[float])->List[float]:
        temp = [0]*len(H)
        for i in range(len(H)):
            temp[i] = -1*H[i]
        return temp

    def windowed_sinc(self, f: int, samp_rate: float, M:int) -> List[float]:
        """
        Here we will introduce a Digital filter making use of the convolution in the time domain.
        Inputs:
            inp : One dimensional -- single list
            f : center frequency of the filter
            M : length of the filter
            filter 
            samp_rate : sampling rate.
            
        Outputs: 
            Filter kernel : LPF filter kernel of the windowed sinc filter (normalized)

        Function will perform the FFT on the input array, to then multiply it by the windowed sinc filter kernel. Then we add the solutions to this multiplication
        From there we then perform the IFFT and submit that as the output. Then to be pretty, we can plot the output. 
        """

        if M%2 != 0:
            raise ValueError('The length of the filter must be even.')
        H = [0]*(M+1)
        summa = 0

        fc = f/samp_rate

        for i in range(len(H)):
            if i-M/2 == 0:
                H[i] = -1 * 2*np.pi*fc #K = 1
            else:
                #H[i] = (np.sin(2*np.pi*fc*(i-M/2))/(i-M/2)) * np.blackman(2*np.pi*i/M) #K = 1
                H[i] = (np.sin(2*np.pi*fc*(i-M/2))/(i-M/2)) * ( 0.42-0.5*np.cos(2*np.pi*i/M) + 0.08*np.cos(4*np.pi*i/M)) #K = 1
            summa += H[i]

        for i in range(len(H)):
            H[i] /= summa
        return H

    def w_sinc_LPF(self, inp: np.array, f: int, samp_rate: float, M:int) -> np.array:
        H = self.windowed_sinc(f,samp_rate,M)
        H_pad = H + [0]*(len(inp)-len(H))
        inp_fft = np.fft.fft(inp)
        H_pad_fft = np.fft.fft(H_pad)
        out = np.fft.ifft(inp_fft*H_pad_fft)
        return out
    
    def w_sinc_HPF(self, inp: np.array, f: int, samp_rate: float, M:int) -> np.array:
        H = self.windowed_sinc(f,samp_rate,M)
        H_pad = H + [0]*abs(len(H)-len(inp))
        inp_fft = np.fft.fft(inp)
        lpf_H_pad_fft = np.fft.fft(H_pad)
        H_pad_fft_temp = lpf_H_pad_fft[len(lpf_H_pad_fft)//2:]
        H_pad_fft_lst = H_pad_fft_temp.tolist() + [1]*(abs(len(H_pad_fft_temp)-len(inp_fft)))
        H_pad_fft = np.array(H_pad_fft_lst)
        out = np.fft.ifft(inp_fft*H_pad_fft)
        return out

    def w_sinc_LPF2(self, inp: np.array, f: int, samp_rate: float, M: int) -> np.array:
        """
        Convolution to form the filtered wave
        """
        out = inp
        H = self.windowed_sinc(f,samp_rate,M) 
        H_pad = H + [0]*(len(inp)-len(H))
        for i in range(M,len(inp)):
            out[i] = 0
            for j in range(len(H_pad)):
                out[i] += inp[i-j]*H_pad[j]
        return out
    
    def w_sinc_BPF(self, inp:np.array, f1: int, f2: int, samp_rate: float, M1:int, M2:int)-> np.array:
        out1 = self.w_sinc_HPF(inp,f1,samp_rate,M1)
        out2 = self.w_sinc_LPF(inp,f2,samp_rate,M2)
        return out1+out2

f1 = 1000
f2 = 5000
f3 = 2000
f4 = 4000
samp_rate = 15360.0
samps = 15360

y1 = [np.sin(2*np.pi*f1*i/samp_rate) for i in range(samps)]
y2 = [np.sin(2*np.pi*f2*i/samp_rate) for i in range(samps)]
y3 = [np.sin(2*np.pi*f3*i/samp_rate) for i in range(samps)]
y4 = [np.sin(2*np.pi*f4*i/samp_rate) for i in range(samps)]

y1 = np.array(y1)
y2 = np.array(y2)
y3 = np.array(y3)
y4 = np.array(y4)
y = y1 + y2 + y3 + y4
noise = y1 + y2 + y3
y_f = np.fft.fft(y)
freq_b = (np.abs(y_f))
y_fil = filter().w_sinc_LPF(y,4500,samp_rate,1000)
y_fft = np.fft.fft(y_fil)
freq_a = (np.abs(y_fft))
x = filter().windowed_sinc(4500,samp_rate,1000)
x_fft = np.abs(np.fft.fft(x))

plt.subplot(5,1,1)
plt.title("Original wave (noise inclv)") 
plt.subplots_adjust(hspace=.5)
plt.plot(y[:4000])
plt.subplot(5,1,2)
plt.title('Freq before Filtering')
plt.plot(freq_b[:4500])
plt.subplot(5,1,3)
plt.title('Filtered signal 1')
plt.plot(y_fil[:4000])
plt.subplot(5,1,4)
plt.title('Freq After filtering signal')
plt.plot(freq_a[:4500])
plt.subplot(5,1,5)
plt.plot(x_fft)
plt.title('FFT of kernel')

plt.show()
