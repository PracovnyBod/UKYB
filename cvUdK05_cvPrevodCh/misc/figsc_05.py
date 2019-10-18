# coding: utf-8


figNamePrefix = 'cv04_fig_'

figPlotParam = fcnDefaultFigSize(5.5, 0.14, 0.85, 0.15, 0.45, 13)
fig = plt.figure(figNameNum, figsize=figPlotParam[0:2])

subPlots = gridspec.GridSpec(1, 1, height_ratios=[100, ])

#------------------
ax0 = plt.subplot(subPlots[0])


ax0.set_title(u'Výstupná veličina', x=0.01, y=1.02, ha='left')
ax0.set_ylabel(u'Uhol [°]', y=1, ha='right', rotation='vertical')

ax0.plot(suroveData[:,0][tmpMask], suroveData[:,1][tmpMask],
         '-k', lw=0.8,
         )


ax0.plot(ustVystCas, ustVystHodnoty,
             '-r', lw=2,
             )

ax0.plot(ustInterval, [ustPriemer, ustPriemer],
 '-b', lw=2,
)


ax0.text(ustInterval[-1]+0.1, ustPriemer,
    u' ustálená\n hodnota\n (priemer)',
    ha='left', va='center',
    color='blue',
)


#------------------
# ax1 = plt.subplot(subPlots[1])
#
#
# ax1.set_title(u'Vstupná veličina', x=0.01, y=1.02, ha='left')
# ax1.set_ylabel(u'$u(t)$ [kg m$^2$ s$^{-2}$]', y=1, ha='right', rotation='vertical')
#
# ax1.plot(t_log[tmpMask], u_log[tmpMask],
#          '-k', lw=0.8, drawstyle='steps-post',
#          )


#------------------
for ax in fig.get_axes():
    ax.set_xlabel(u'čas [s]', x=1.05,  ha='left', va='bottom')

#------------------
fcnDefaultLayoutAdj(fig, figPlotParam[2], figPlotParam[3], figPlotParam[4], figPlotParam[5])

for ax in fig.get_axes():
    fcnDefaultAxisStyle(ax)
    handles_ax, labels_ax = ax.get_legend_handles_labels()

    ax.xaxis.set_minor_locator(AutoMinorLocator())
    ax.yaxis.set_minor_locator(AutoMinorLocator())

    if ax == ax0:
        ax.legend(handles_ax, labels_ax, loc=1, bbox_to_anchor=(0.98, 1.12))

#------------------

plt.savefig('./fig/' + figNamePrefix + '{}'.format(figNameNum) +'.pdf')
