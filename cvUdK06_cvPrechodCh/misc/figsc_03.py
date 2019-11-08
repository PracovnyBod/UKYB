# coding: utf-8


figNamePrefix = 'cv07_fig_'

figPlotParam = fcnDefaultFigSize(8.4, 0.15, 0.9, 0.12, 0.45, 13)
fig = plt.figure(figNameNum, figsize=figPlotParam[0:2])

subPlots = gridspec.GridSpec(1, 1, height_ratios=[100, ])

#------------------
ax0 = plt.subplot(subPlots[0])


ax0.set_title(u'Prevodová charakteristika', x=0.01, y=1.02, ha='left')
ax0.set_ylabel(u'Uhol [°]', y=1, ha='right', va='bottom', rotation='vertical')
ax0.set_xlabel(u'Vstup\n$u$ [kg m$^2$ s$^{-2}$]', x=1.05, ha='left', va='bottom', rotation='vertical')

ax0.plot(prevodChar[:,0], prevodChar[:,1],
         '+r', ms=9, mew=1,
         label=u'Namerané dáta'
         )

ax0.plot(u_ine, y_ine_1,
         '.b', ms=3, mew=1,
         label=u'Model'
         )


#------------------
# for ax in fig.get_axes():
    # ax.set_xlabel(u'čas [s]', x=1.05,  ha='left', va='bottom')

#------------------
fcnDefaultLayoutAdj(fig, figPlotParam[2], figPlotParam[3], figPlotParam[4], figPlotParam[5])

for ax in fig.get_axes():
    fcnDefaultAxisStyle(ax)
    handles_ax, labels_ax = ax.get_legend_handles_labels()

    if ax == ax0:
        ax.legend(handles_ax, labels_ax, ncol=2, loc=1, bbox_to_anchor=(0.98, 1.1))

#------------------

# plt.savefig('fig/' + figNamePrefix + '{}'.format(figNameNum) +'.png', dpi=200)
plt.savefig('./fig/' + figNamePrefix + '{}'.format(figNameNum) +'.pdf')
