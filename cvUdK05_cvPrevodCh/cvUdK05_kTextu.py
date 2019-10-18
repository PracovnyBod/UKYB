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


def fcn_rovniceKyvadla(x, t, u):

    x_1, x_2 = x

    m = 1
    l = 1
    g = 9.81
    beta = 2 * 1.0 * np.sqrt(g/l)

    dotx_1 = x_2
    dotx_2 = -(beta/(m*l**2)) * x_2 - (g/l) * np.sin(x_1) + (1/(m*l**2)) * u

    return [dotx_1, dotx_2]


# %% -------------------------------------------------------------------------




def fcn_simSch01(t_start, T_s, finalIndex, u_tabulka):

    #-----------------------------------------
    # casovy vektor

    t_log = np.zeros([finalIndex, 1])
    t_log[0,:] = t_start

    #-----------------------------------------
    # vektor stavu riadeneho systemu

    x_0 = np.array([0, 0])

    x_log = np.zeros([finalIndex, len(x_0)])
    x_log[0,:] = x_0

    #-----------------------------------------
    # vektor akcneho zasahu

    u_log = np.zeros([finalIndex, 1])

    for idx in range(u_log.shape[0]):
        lastValue = u_tabulka[:,1][u_tabulka[:,0] <= idx*T_s ][-1]
        u_log[idx] = lastValue

    #-----------------------------------------

    timespan = np.zeros(2)
    for idx in range(1, int(finalIndex)):

        #-------------------------------------
        # Riadeny system - simulacia (pomocou ODEsolvera)

        timespan[0] = t_log[idx-1,:]
        timespan[1] = t_log[idx-1,:] + T_s

        odeOut = odeint(fcn_rovniceKyvadla,
                        x_log[idx-1,:],
                        timespan,
                        args=(u_log[idx-1,:],)
                        )

        x_log[idx,:] = odeOut[-1,:]
        t_log[idx,:] = timespan[-1]

    # y bude umelo zasumeny vystup
    y = (x_log[:,0].reshape(-1,1)*180/np.pi) + ((np.random.rand(x_log[:,0].shape[0],1)-0.5)*2.5)


    return [t_log, x_log, u_log, y]


# %% -------------------------------------------------------------------------



# %% -------------------------------------------------------------------------

u_tabulka = np.array([
                [0, 0.0],
                [10, 1.0],
                [20, 2.0],
                [30, 3.0],
                [40, 4.0],
                [50, 5.0],
                [60, 6.0],
                [70, 7.0],
                [80, 8.0],
                [95, 9.0],
                [110, 9.5],
                [135, 9.81],
                [180, 9.81],
                ])

# %% -------------------------------------------------------------------------


# Nastavenia simulacie

sim_t_start = 0
sim_t_final = u_tabulka[-1,0]
sim_T_s = 0.1
sim_finalIndex = int(((sim_t_final - sim_t_start)/sim_T_s) + 1)


# Simulacia
t_log, x_log, u_log, y = fcn_simSch01(sim_t_start, sim_T_s, sim_finalIndex, u_tabulka)

suroveData = np.hstack([t_log, y])



# %% -------------------------------------------------------------------------

figNameNum = 1
exec(open('./misc/figsc_01.py', encoding='utf-8').read())


# %% -------------------------------------------------------------------------




figNameNum = 2
exec(open('./misc/figsc_02.py', encoding='utf-8').read())



# %% -------------------------------------------------------------------------





tmpInterval = [u_tabulka[1][0] + (u_tabulka[2][0]-u_tabulka[1][0])*0,
                   u_tabulka[2][0]
                   ]

tmpMask = np.logical_and(suroveData[:,0]>tmpInterval[0], suroveData[:,0]<=tmpInterval[1])





figNameNum = 3
exec(open('./misc/figsc_03.py', encoding='utf-8').read())




# %% -------------------------------------------------------------------------





ustVstup =  u_tabulka[1][1]
ustInterval = [u_tabulka[1][0] + (u_tabulka[2][0]-u_tabulka[1][0])*0.7,
               u_tabulka[2][0]
               ]

boolMaska = np.logical_and(suroveData[:,0]>ustInterval[0], suroveData[:,0]<=ustInterval[1])

ustVystCas = suroveData[boolMaska, 0]
ustVystHodnoty = suroveData[boolMaska, 1]

ustPriemer = np.mean(ustVystHodnoty)



figNameNum = 4
exec(open('./misc/figsc_04.py', encoding='utf-8').read())



# %% -------------------------------------------------------------------------






figNameNum = 5
exec(open('./misc/figsc_05.py', encoding='utf-8').read())


# %% -------------------------------------------------------------------------



figNameNum = 6
exec(open('./misc/figsc_06.py', encoding='utf-8').read())



# %% -------------------------------------------------------------------------


prevodChar = np.zeros([u_tabulka.shape[0] - 1, 2])

for idx in range(1, u_tabulka.shape[0]):

    ustVstup =  u_tabulka[idx-1][1]
    ustInterval = [u_tabulka[idx-1][0] + (u_tabulka[idx][0]-u_tabulka[idx-1][0])*0.7,
                   u_tabulka[idx][0]
                   ]

    boolMaska = np.logical_and(suroveData[:,0]>ustInterval[0], suroveData[:,0]<=ustInterval[1])

    ustVystCas = suroveData[boolMaska, 0]
    ustVystHodnoty = suroveData[boolMaska, 1]

    ustPriemer = np.mean(ustVystHodnoty)

    prevodChar[idx-1, 0] = ustVstup
    prevodChar[idx-1, 1] = ustPriemer



np.savetxt('./misc/dataRepo/prevodChar.csv', prevodChar)
print(prevodChar)


# %% -------------------------------------------------------------------------








# %% -------------------------------------------------------------------------



figNameNum = 7
exec(open('./misc/figsc_07.py', encoding='utf-8').read())







# %% -------------------------------------------------------------------------









# %% -------------------------------------------------------------------------









# %% -------------------------------------------------------------------------
