# -*- coding: utf-8 -*-

class Prova:
    
    def __init__(self,**kwargs):
        self.a=kwargs["a"]
        self.b=kwargs["b"]
        self.c=kwargs["c"]

prova = Prova(**{"a":1,"b":2,"c":3})

