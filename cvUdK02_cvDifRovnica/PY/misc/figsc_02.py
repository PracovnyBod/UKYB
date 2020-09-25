# coding: utf-8


figNamePrefix = 'cv01_fig_'

figPlotParam = fcnDefaultFigSize(6, 0.14, 0.88, 0.15, 0.4, 13)
fig = plt.figure(figNameNum, figsize=figPlotParam[0:2])

subPlots = gridspec.GridSpec(1, 1, )

#------------------
ax0 = plt.subplot(subPlots[0])

ax0.set_title(u'Napätie na kondenzátore', x=0.01, y=1.02, ha='left')
ax0.set_ylabel(u'[V]', y=1.02, ha='right', va='bottom', rotation='horizontal', )

ax0.plot(t_log, sig_napatie,
         '-', lw=0.8, color='k', ms=5, mec='None', mfc='k',
         label=u'$u(t)$',
         )

#------------------
for ax in fig.get_axes():
    ax.set_xlabel(u'čas [s]', x=1.05, ha='left', va='center')

#------------------
fcnDefaultLayoutAdj(fig, figPlotParam[2], figPlotParam[3], figPlotParam[4], figPlotParam[5])

for ax in fig.get_axes():
    fcnDefaultAxisStyle(ax)
    handles_ax, labels_ax = ax.get_legend_handles_labels()

    if ax == ax0:
        ax.legend(handles_ax, labels_ax, loc=1, bbox_to_anchor=(0.98, 1.12))

#------------------

plt.savefig('./fig/' + figNamePrefix + '{}'.format(figNameNum) +'.png', dpi=200)
plt.savefig('./fig/' + figNamePrefix + '{}'.format(figNameNum) +'.pdf')
