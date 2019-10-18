# -*- coding: utf-8 -*-

# %% -------------------------------------------------------------------------



%load_ext autoreload
%autoreload


import numpy as np
from scipy.integrate import odeint

# %% ---------------------------------------------------------------------------

import sys
sys.path.append('./misc/')

from figFcns_Tex import *

# %% -------------------------------------------------------------------------


# %% -------------------------------------------------------------------------





# %% -------------------------------------------------------------------------


prevodChar = np.loadtxt('./misc/dataRepo/prevodChar.csv')



# %% -------------------------------------------------------------------------




figNameNum = 1
exec(open('./misc/figsc_01_a.py', encoding='utf-8').read())













# %% -------------------------------------------------------------------------




# pouzitie funkcie polyfit (z modulu numpy)

polyKoef = np.polyfit(prevodChar[:,0],prevodChar[:,1], 3)



print(polyKoef)

# %% -------------------------------------------------------------------------


# funkcia polyval pouzita pre vypocet aproximacie nameranych hodnot vystupu
y_hat = np.polyval(polyKoef, prevodChar[:,0])


print(y_hat)


# %% -------------------------------------------------------------------------

figNameNum = 2
exec(open('./misc/figsc_02_a.py', encoding='utf-8').read())



# %% -------------------------------------------------------------------------


# vypocitanie aproximacie vystupu pre rozne vstupne hodnoty
u_ine = np.arange(0,9.81,0.1)
y_ine_1 = np.polyval(polyKoef, u_ine)



# %% -------------------------------------------------------------------------


figNameNum = 3
exec(open('./misc/figsc_03_a.py', encoding='utf-8').read())

# %% -------------------------------------------------------------------------



# %% -------------------------------------------------------------------------






# zostavenie matice H a vektora y

H = np.hstack([
        (prevodChar[:,0].reshape(-1,1))**3,
        (prevodChar[:,0].reshape(-1,1))**2,
        prevodChar[:,0].reshape(-1,1),
        np.ones([prevodChar[:,0].shape[0],1]),
        ])

y = prevodChar[:,1].reshape(-1,1)



# %% -------------------------------------------------------------------------



# Riesenie preurceneho systemu rovnic v zmysle metody najmensich stvorcov
Theta = np.linalg.lstsq(H, y, rcond=None)[0]













# %% -------------------------------------------------------------------------











# %% -------------------------------------------------------------------------





# Pouzitie Gaussovho vzorca
Theta_1 = np.matmul(np.matmul(np.linalg.inv(np.matmul(H.T, H)), H.T), y)

# %% ---------------------
print ('matica H je:\n')
print (H)

print ('\n')

print ('vektor y je:\n')
print (y)

print ('\n')

print ('vypocitane parametre \Theta su:\n')
print (Theta_1)



# %% -------------------------------------------------------------------------

y_model = np.matmul(H,Theta_1)

print ('vystup modelu pre dane (namerane) vstupy:\n')
print (y_model)



# %% -------------------------------------------------------------------------






# %% -------------------------------------------------------------------------
