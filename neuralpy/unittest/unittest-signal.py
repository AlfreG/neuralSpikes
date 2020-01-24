# -*- coding: utf-8 -*-
import sys
from pathlib import Path
file = Path("__file__").resolve()
parent, root = file.parent, file.parents[1]
sys.path.append(str(root))

import unittest
import nsignal as ns
import numpy as np
import scipy.stats as st


class TestSample(unittest.TestCase):
        
    # Test attributes
    def test_attr_elapse(self):
        param = {"sfreq":10.8,"elapse":1}
        result = ns.Sample(**param).elapse
        self.assertEqual(result,param["elapse"])
    def test_attr_sfreq(self):
        param = {"sfreq":10.8,"elapse":1}
        result = ns.Sample(**param).sfreq
        self.assertEqual(result,param["sfreq"])
    
    # test correct sizes
    def test_size_sample(self):
        param = {"sfreq":10,"elapse":1.22}
        result = ns.Sample(**param).get_sample_size()
        self.assertEqual(result,12)
    def test_size_freq(self):
        param = {"sfreq":10,"elapse":1.31}
        result = ns.Sample(**param).get_freqs().size
        self.assertEqual(result,13)
    def test_equal_size(self):
        param = {"sfreq":10.8,"elapse":1.3}
        time_size = ns.Sample(**param).get_times().size
        freq_size = ns.Sample(**param).get_freqs().size
        self.assertEqual(time_size,freq_size)


class TestImpulse(unittest.TestCase):
    
    param = {"sfreq":10,"elapse":1.91
              ,"width":0.4,"height":0.06,"shape_fun":st.norm.pdf}
    
    # test attributes
    def test_attr_elapse(self):
        result = ns.Impulse(**self.param).elapse
        self.assertEquals(result,self.param["elapse"])
    def test_attr_sfreq(self):
        result = ns.Impulse(**self.param).sfreq
        self.assertEquals(result,self.param["sfreq"])
    
    # test correct sizes
    def test_size_size(self):        
        result = ns.Impulse(**self.param).get_sample_size()
        self.assertEquals(result,19)
    def test_size_cfreq(self):
        result = ns.Impulse(**self.param).get_freqs().size
        self.assertEquals(result,19)
    def test_size_time(self):
        result = ns.Impulse(**self.param).get_times().size
        self.assertEquals(result,19)
    def test_impulse_size(self):
        result = ns.Impulse(**self.param).get_impulse_size()
        self.assertEquals(result,5)


    # Test impulse data
    # def test_impulse_sample(self):
    #     result = ns.Impulse(**self.param).get_impulse_samples()
    #     self.assertEqual(result, 
    #                      [-0.02, -0.01, 0, 0.01, 0.02]
    #                      )
    # def test_impulse_data(self):
    #     result = ns.Impulse(**self.param).get_impulse()
    #     self.assertEqual(result,
    #                      self.param["shape_fun"](
    #                          [-0.02, -0.01, 0, 0.02, 0.01])
    #                      )
    def test_impulse_fun(self):
        # test shape function
        result = ns.Impulse(**self.param).shape_fun(0)
        self.assertEquals(result,self.param["shape_fun"](0))
    

class TestImpulseTrain(unittest.TestCase):
    
    param = {"sfreq":10,"elapse":10
              ,"width":0.4,"height":0.06,"shape_fun":st.norm.pdf
              ,"spike_rate":5}
    
    #
    def test_spike_count(self):
        result = ns.ImpulseTrain(**self.param).get_spikes_count()
        self.assertEquals(result,50-1)

    #
    def test_spike_times(self):
        result = ns.ImpulseTrain(**self.param).get_spike_times()
        self.assertIn(list(result), range(0,100))
        

class Signal(unittest.TestCase):
    
    param = {"sfreq":10,"elapse":10
              ,"width":0.4,"height":0.06,"shape_fun":st.norm.pdf
              ,"spike_rate":5
              ,"noise_mean":0
              ,"noise_var":1}

    # test attributes
    def test_size_signal(self):
        result = ns.Signal(**self.param).get_signal().size
        self.assertEquals(result,100)



if __name__=="__main__":
    unittest.main()


