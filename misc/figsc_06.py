# coding: utf-8


figNamePrefix = 'fig_'

figPlotParam = fcnDefaultFigSize(11, 0.15, 0.93, 0.08, 0.35, 13)
fig = plt.figure(figNameNum, figsize=figPlotParam[0:2])

subPlots = gridspec.GridSpec(1, 1, )

#------------------
ax0 = plt.subplot(subPlots[0])

ax0.set_title(u'Prevodová charakteristika', x=0.01, y=1.02, ha='left')
ax0.set_ylabel(u'Uhol [°]', y=1, ha='right', rotation='vertical')
ax0.set_xlabel(u'Vstup\n$u$ [kg m$^2$ s$^{-2}$]', x=1.05, ha='left', va='bottom')


ax0.plot(u_ine, y_model,
         '.', color='gray', ms=4, mew=0,
         label=u'Model prevodovej charakteristiky'
         )

ax0.plot(u_PB1, y_PB1,
         '+', ms=10, mew=2, mec='r',
         label=u'1.PB'
         )

ax0.plot(u_PB2, y_PB2,
         '+', ms=10, mew=2, mec='b',
         label=u'2.PB'
         )


#-------------
#Doplnujuce info v obr:

ax0.plot(u_PB1, 0,
         '|', ms=15, mew=1, mec='r',
         )
ax0.text(u_PB1, 3,
         u'$u_{PB1}$',
         ha='center', va='bottom', fontsize=14,
        )
ax0.plot(0, y_PB1,
         '_', ms=15, mew=1, mec='r',
         )
ax0.text(0.3, y_PB1,
         u'$y_{PB1}$',
         ha='left', va='center', fontsize=14,
        )

ax0.plot(u_PB2, 0,
         '|', ms=15, mew=1, mec='b',
         )
ax0.text(u_PB2, 3,
         u'$u_{PB2}$',
         ha='center', va='bottom', fontsize=14,
        )
ax0.plot(0, y_PB2,
         '_', ms=15, mew=1, mec='b',
         )
ax0.text(0.3, y_PB2,
         u'$y_{PB2}$',
         ha='left', va='center', fontsize=14,
        )




#------------------
fcnDefaultLayoutAdj(fig, figPlotParam[2], figPlotParam[3], figPlotParam[4], figPlotParam[5])

for ax in fig.get_axes():
    fcnDefaultAxisStyle(ax)
    handles_ax, labels_ax = ax.get_legend_handles_labels()

    if ax == ax0:
        ax.legend(handles_ax, labels_ax,
           loc=2, bbox_to_anchor=(0.02, 0.69), ncol=1,
           )

#------------------

# plt.savefig('fig/' + figNamePrefix + '{}'.format(figNameNum) +'.png', dpi=200)
plt.savefig('fig/' + figNamePrefix + '{}'.format(figNameNum) +'.pdf')
