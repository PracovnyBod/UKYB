# coding: utf-8


figNamePrefix = 'fig_'

figPlotParam = fcnDefaultFigSize(11, 0.09, 0.94, 0.07, 0.35, 13)
fig = plt.figure(figNameNum, figsize=figPlotParam[0:2])

subPlots = gridspec.GridSpec(2, 1, height_ratios=[70, 30] )

#------------------
ax0 = plt.subplot(subPlots[0])

ax0.set_title(u'Výstupná veličina', x=0.01, y=1.02, ha='left')
ax0.set_ylabel(u'Uhol [°]', y=1, ha='right', rotation='vertical')

ax0.plot(suroveData[:,0], suroveData[:,1],
         '-k', lw=0.8,
         )

#------------------
ax1 = plt.subplot(subPlots[1])

ax1.set_title(u'Vstupná veličina', x=0.01, y=1.02, ha='left')
ax1.set_ylabel(u'$u(t)$ [kg m$^2$ s$^{-2}$]', y=1, ha='right', rotation='vertical')

ax1.plot(t_log, u_log,
         '-k', lw=0.8, drawstyle='steps-post',
         )
