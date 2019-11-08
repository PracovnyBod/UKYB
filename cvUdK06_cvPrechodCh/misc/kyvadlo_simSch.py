# -*- coding: utf-8 -*-

import numpy as np
from scipy.integrate import odeint

def fcn_rovniceKyvadla(x, t, u):

    x_1, x_2 = x

    m = 1
    l = 1
    g = 9.81
    beta = 2 * 1.0 * np.sqrt(g/l)

    dotx_1 = x_2
    dotx_2 = -(beta/(m*l**2)) * x_2 - (g/l) * np.sin(x_1) + (1/(m*l**2)) * u

    return [dotx_1, dotx_2]






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
    y[0,:] = x_log[0,0]


    return [t_log, x_log, u_log, y]
