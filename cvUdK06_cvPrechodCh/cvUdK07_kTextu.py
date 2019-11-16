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

from kyvadlo_simSch import *



# %% -------------------------------------------------------------------------





# %% -------------------------------------------------------------------------





# %% -------------------------------------------------------------------------


prevodChar = np.loadtxt('./misc/dataRepo/prevodChar.csv')



# %% -------------------------------------------------------------------------


figNameNum = 1
# execfile(cwdPath + '/misc/figsc_01.py')
exec(open('./misc/figsc_01.py', encoding='utf-8').read())







# %% -------------------------------------------------------------------------

# pouzitie funkcie polyfit (z modulu numpy)

polyKoef = np.polyfit(prevodChar[:,0],prevodChar[:,1], 3)


print(polyKoef)

# %% -------------------------------------------------------------------------

# vypocitanie aproximacie vystupu pre rozne vstupne hodnoty
u_ine = np.arange(0,9.81,0.1)
y_ine_1 = np.polyval(polyKoef, u_ine)


# %% -------------------------------------------------------------------------


figNameNum = 2
# execfile(cwdPath + '/misc/figsc_03.py')
exec(open('./misc/figsc_03.py', encoding='utf-8').read())



# %% -------------------------------------------------------------------------



theta = polyKoef
theta = theta[-1::-1]


# %% -------------------------------------------------------------------------


u_PB1 = 4.0
y_PB1 =  theta[0] + theta[1] * u_PB1 + theta[2] * u_PB1**2 + theta[3] * u_PB1**3
print( u'y_PB1 = {:6.2f} [°]'.format(y_PB1))



# %% -------------------------------------------------------------------------

u_PB2 = 9.5
y_PB2 = theta[0] + theta[1] * u_PB2 + theta[2] * u_PB2**2 + theta[3] * u_PB2**3
print( u'y_PB2 = {:6.2f} [°]'.format(y_PB2))





# %% -------------------------------------------------------------------------


figNameNum = 4
# execfile(cwdPath + '/misc/figsc_04.py')
exec(open('./misc/figsc_04.py', encoding='utf-8').read())


# %% -------------------------------------------------------------------------




u_PB1_okol = 0.8

y_PB1_h = theta[0] + theta[1] * (u_PB1+u_PB1_okol) + theta[2] * (u_PB1+u_PB1_okol)**2 + theta[3] * (u_PB1+u_PB1_okol)**3
y_PB1_l = theta[0] + theta[1] * (u_PB1-u_PB1_okol) + theta[2] * (u_PB1-u_PB1_okol)**2 + theta[3] * (u_PB1-u_PB1_okol)**3

u_PB2_okol = 0.25

y_PB2_h = theta[0] + theta[1] * (u_PB2+u_PB2_okol) + theta[2] * (u_PB2+u_PB2_okol)**2 + theta[3] * (u_PB2+u_PB2_okol)**3
y_PB2_l = theta[0] + theta[1] * (u_PB2-u_PB2_okol) + theta[2] * (u_PB2-u_PB2_okol)**2 + theta[3] * (u_PB2-u_PB2_okol)**3



# %% -------------------------------------------------------------------------


figNameNum = 5
# execfile(cwdPath + '/misc/figsc_05.py')
exec(open('./misc/figsc_05.py', encoding='utf-8').read())



# %% -------------------------------------------------------------------------


u_tabulka = np.array([
                [0, u_PB1],
                [10, u_PB1+u_PB1_okol],
                ])



# %% -------------------------------------------------------------------------

# Nastavenia simulacie

sim_t_start = 0
sim_t_final = 20
sim_T_s = 0.025
sim_finalIndex = int(((sim_t_final - sim_t_start)/sim_T_s) + 1)

# Simulacia
t_log, x_log, u_log, vystVelicina = fcn_simSch01(sim_t_start, sim_T_s, sim_finalIndex, u_tabulka)


# %% -------------------------------------------------------------------------


figNameNum = 6
# execfile(cwdPath + '/misc/figsc_06.py')
exec(open('./misc/figsc_06.py', encoding='utf-8').read())


# %% -------------------------------------------------------------------------



print( u'y_PB1 = {:6.2f} [°]'.format(y_PB1))




# %% -------------------------------------------------------------------------

temp_Mask = np.logical_and((t_log < 10), (t_log>5))
y_PB1_data = np.mean(vystVelicina[temp_Mask])

print( u'y_PB1_data     = {:6.2f} [°]'.format(y_PB1_data))
print( u'y_PB1_odchylka = {:6.2f} [°]'.format(y_PB1_data - y_PB1) + u',   to je {:5.2f} [%]'.format(((y_PB1_data - y_PB1)/y_PB1)*100))





# %% -------------------------------------------------------------------------

print( u'y_PB1_h     = {:6.2f} [°]'.format(y_PB1_h))







# %% -------------------------------------------------------------------------

temp_Mask = np.logical_and((t_log <= 15), (t_log>12.5))
y_PB1_h_data = np.mean(vystVelicina[temp_Mask])

print( u'y_PB1_h_data     = {:6.2f} [°]'.format(y_PB1_h_data))




# %% -------------------------------------------------------------------------







# %% -------------------------------------------------------------------------



temp_Mask = np.logical_and((t_log >= 10), (t_log <= 15))

surovaPCH_t = t_log[temp_Mask]
surovaPCH_y = vystVelicina[temp_Mask]
surovaPCH_u = u_log[temp_Mask]



# %% -------------------------------------------------------------------------



figNameNum = 7
# execfile(cwdPath + '/misc/figsc_07.py')
exec(open('./misc/figsc_07.py', encoding='utf-8').read())


# %% -------------------------------------------------------------------------

posunutaPCH_t = surovaPCH_t - 10.0
posunutaPCH_y = surovaPCH_y - y_PB1
posunutaPCH_u = surovaPCH_u - u_PB1



# %% -------------------------------------------------------------------------


figNameNum = 8
# execfile(cwdPath + '/misc/figsc_08.py')
exec(open('./misc/figsc_08.py', encoding='utf-8').read())




# %% -------------------------------------------------------------------------


prechodChar = np.hstack([posunutaPCH_t.reshape(-1,1), posunutaPCH_y.reshape(-1,1), posunutaPCH_u.reshape(-1,1)])

np.savetxt('./misc/dataRepo/prechodChar.csv', prechodChar)
np.savetxt('./misc/dataRepo/zvolenePracovneBody.csv', [u_PB1, u_PB1_okol, u_PB2, u_PB2_okol])


# %% -------------------------------------------------------------------------
# %% -------------------------------------------------------------------------
# %% -------------------------------------------------------------------------


prechodChar = np.loadtxt('./misc/dataRepo/prechodChar.csv')

posunutaPCH_t = prechodChar[:,0]
posunutaPCH_y = prechodChar[:,1]
posunutaPCH_u = prechodChar[:,2]






# %% -------------------------------------------------------------------------

figNameNum = 1
# execfile(cwdPath + '/misc/figsc_01.py')
exec(open('./misc/figsc_10_01.py', encoding='utf-8').read())






# %% -------------------------------------------------------------------------




theta = np.loadtxt('./misc/dataRepo/theta_poly3order.csv')

theta = theta[-1::-1]   # bude potrebne opacne poradie oproti tomu ako je to ulozene

u_PB1, u_PB1_okol, u_PB2, u_PB2_okol = np.loadtxt('./misc/dataRepo/zvolenePracovneBody.csv')



# %% -------------------------------------------------------------------------

y_PB1 =  theta[0] + theta[1] * u_PB1 + theta[2] * u_PB1**2 + theta[3] * u_PB1**3
y_PB1_h = theta[0] + theta[1] * (u_PB1+u_PB1_okol) + theta[2] * (u_PB1+u_PB1_okol)**2 + theta[3] * (u_PB1+u_PB1_okol)**3
y_PB1_l = theta[0] + theta[1] * (u_PB1-u_PB1_okol) + theta[2] * (u_PB1-u_PB1_okol)**2 + theta[3] * (u_PB1-u_PB1_okol)**3


print(y_PB1_h)

print(y_PB1_h - y_PB1)


# %% -------------------------------------------------------------------------


temp_Mask = posunutaPCH_t >= 3.0
Delta_y = np.mean(posunutaPCH_y[temp_Mask])

print(u'Delta_y = {:6.2f} [°]'.format(Delta_y))

K = Delta_y/u_PB1_okol

print(u'K = {:6.2f} [°/(kg m^2 s^-2)]'.format(K))


figNameNum = 2
exec(open('./misc/figsc_10_02.py', encoding='utf-8').read())


# %% -------------------------------------------------------------------------


Delta_y63 = Delta_y * 0.63
print(u'Delta_y63 = {:6.2f}'.format(Delta_y63) + u'  [°]')


# %% -------------------------------------------------------------------------

temp_pct = 0.1
temp_Mask = np.logical_and( (posunutaPCH_y >= (Delta_y63-(Delta_y63*temp_pct))), (posunutaPCH_y <= (Delta_y63+(Delta_y63*temp_pct))))
print(posunutaPCH_t[temp_Mask])


# %% -------------------------------------------------------------------------

T = np.mean(posunutaPCH_t[temp_Mask])
print(u'T = {:6.2f}'.format(T) + u'  [s]')


# %% -------------------------------------------------------------------------


figNameNum = 3
exec(open('./misc/figsc_10_03.py', encoding='utf-8').read())



# %% -------------------------------------------------------------------------



# %% -------------------------------------------------------------------------

def fcn_ss1r(x, t, u):

    dotx = -(1.0/T) * x + (K/T) * u

    return dotx



# %% -------------------------------------------------------------------------

timeVect = np.arange(0, 5.0, 0.1)

# %% -------------------------------------------------------------------------


x = odeint(fcn_ss1r,
           [0],   # začiatočné podmienky
           timeVect,
           args=(u_PB1_okol,),
           )


# %% -------------------------------------------------------------------------

figNameNum = 4
exec(open('./misc/figsc_10_04.py', encoding='utf-8').read())





# %% -------------------------------------------------------------------------


# %% -------------------------------------------------------------------------


# %% -------------------------------------------------------------------------


# %% -------------------------------------------------------------------------


# %% -------------------------------------------------------------------------
