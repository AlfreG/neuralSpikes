# -*- coding: utf-8 -*-

class Sample:
    def __init__(self,elapse,sfreq):
        self.elapse=elapse
        self.sfreq=sfreq
        self.size=self.set_size()
    
    def set_size():
        pass
    
    def set_cfreq():
        pass
    
    def set_time():
        pass
    
    def __print__():
        pass


class Impulse:
    def __init__(self,width,height,shape):
        pass
    
    def set_impulse_power():
        pass
    
    
class ImpulseTrain(Sample,Impulse):
    def __init__(self,time_distribution):
        pass
    
    def set_impulse_train_power():
        pass

    
class ThermalNoise(Sample):
    def __init__(self,noise_distribution):
        pass
    
    def set_noise_power():
        pass


class Signal(Sample,Impulse,ImpulseTrain,ThermalNoise):
    pass


class Simulation(Signal):
    pass

