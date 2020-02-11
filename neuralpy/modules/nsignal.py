# -*- coding: utf-8 -*-
import numpy as np
from math import floor
        
        
class Sample(object):
    __acceptable_keys_list = ['elapse', 'sfreq']
    
    def __init__(self, **kwargs):
        [self.__setattr__(key, kwargs.get(key)) for key in self.__acceptable_keys_list]
        
    def get_times(self):
        return np.arange(0,self.elapse-1/self.sfreq,1/self.sfreq)

    def get_freqs(self):
        sym_freq=self.sym_interval(self.get_sample_size(), 1, 0)
        return sym_freq/self.get_sample_size()*self.sfreq

    def get_sample_size(self):
        return self.get_times().size
    
    def sym_interval(self,length, step, sym=1):
        '''
            if sym=0 return an array of the same length
            if sym=1 return a symmetric interval of length=length+1
        '''
        mid= length/2
        return np.arange(-mid, mid+step*sym, step)

    def __print__(self):
        pass


class Impulse(Sample):
    __acceptable_keys_list = ['heigth', 'width','shape_fun']
    
    def __init__(self, **kwargs):
        [self.__setattr__(key, kwargs.get(key)) for key in self.__acceptable_keys_list]
        Sample.__init__(self,**kwargs)
        
    def get_impulse_samples(self):
        return self.sym_interval(self.width, 1/self.sfreq)
    
    def get_impulse_size(self):
        #
        return self.get_impulse_samples().size
    
    def get_impulse_center(self):
        #
        return floor(self.get_impulse_size()/2)
    
    def get_impulse(self):
        '''
            Impulse of size n, where n is an odd.
        '''
        return self.shape_fun(self.get_impulse_samples())
        
    def get_impulse_power(self):
        return np.sum(np.square(self.get_impulse()))/self.sfreq


class ImpulseTrain(Impulse):
    __acceptable_keys_list = ['spike_rate']
        
    def __init__(self, **kwargs):
        [self.__setattr__(key, kwargs.get(key)) for key in self.__acceptable_keys_list]
        Impulse.__init__(self,**kwargs)    

    def get_spike_times(self):
        avoid_margin=self.width/2
        spike_times = np.arange(avoid_margin, self.elapse-avoid_margin
                          , 1/self.spike_rate) # in seconds
        # turn to sample units and round
        spike_times = spike_times*self.get_sample_size()/self.elapse
        return spike_times.astype("int16")

    def get_spikes_count(self):
        return self.get_spike_times().size

    def get_impulse_train_power(self):
        return self.get_impulse_power()*self.get_spikes_count()


class ThermalNoise(Sample):
    __acceptable_keys_list = ['noise_mean','noise_var']
        
    def __init__(self, **kwargs):
        [self.__setattr__(key, kwargs.get(key)) for key in self.__acceptable_keys_list]
        Sample.__init__(self,**kwargs)

    def get_noise(self):
        return np.random.normal(self.noise_mean,self.noise_var,self.get_sample_size())


class Signal(ImpulseTrain,ThermalNoise):
    #__acceptable_keys_list = ['spike_rate']
        
    def __init__(self, **kwargs):
        #[self.__setattr__(key, kwargs.get(key)) for key in self.__acceptable_keys_list]
        ImpulseTrain.__init__(self,**kwargs)
        ThermalNoise.__init__(self,**kwargs)
        
    def get_signal(self):
        spikes_times = np.asarray(self.get_spike_times())
        impulse = self.get_impulse()
        size = self.get_impulse_size()
        center = np.asarray(self.get_impulse_center())
        
        signal = self.get_noise()
        
        for x in range(-size+center+1,size-center):
            signal[spikes_times+x]+=impulse[center+x]
            
        return signal


class Simulation(Signal):
    pass


class Filter(Signal):
    pass






if __name__=="__main__":
    
    import scipy.stats as st
    import matplotlib.pyplot as plt

    param = {"sfreq":1000,"elapse":1,
             "width":0.01,"height":0.06,
             "shape_fun":st.norm.pdf,
             "spike_rate":5,
             "noise_mean":0,
             "noise_var":0.01 \
             }
    
    signal=Signal(**param)  
