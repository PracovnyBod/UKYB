# -*- coding: utf-8 -*-

import matplotlib as mpl
import matplotlib.pyplot as plt
import matplotlib.gridspec as gridspec

###############################################################################
mpl.rcParams['figure.dpi'] = 100

mpl.rcParams['font.family'] = 'Times New Roman'
mpl.rcParams['mathtext.fontset'] = 'stix'


mpl.rcParams['font.size'] = 12

mpl.rcParams['xtick.direction'] = 'out'
mpl.rcParams['xtick.labelsize'] = mpl.rcParams['font.size']

mpl.rcParams['ytick.direction'] = 'out'
mpl.rcParams['ytick.labelsize'] = mpl.rcParams['font.size']

mpl.rcParams['axes.titlesize'] = mpl.rcParams['font.size']
mpl.rcParams['axes.labelsize'] = mpl.rcParams['font.size']
mpl.rcParams['legend.fontsize'] = mpl.rcParams['font.size']#'small'#
mpl.rcParams['legend.frameon'] = False
mpl.rcParams['legend.borderpad'] = 0.1
mpl.rcParams['legend.borderaxespad'] = 0.0
mpl.rcParams['legend.labelspacing'] = 0.2
mpl.rcParams['legend.numpoints'] = 1

###############################################################################

def fcnDefaultAxisStyle(ax):
    ax.grid(color='#666666')
    ax.set_axisbelow(True)
    ax.spines['top'].set_visible(False)
    ax.spines['right'].set_visible(False)
    ax.get_xaxis().tick_bottom()
    ax.get_yaxis().tick_left()


def fcnDefaultTwinAxisStyle(ax):
    ax.spines['top'].set_visible(False)
    ax.spines['left'].set_visible(False)


def fcnDefaultLayoutAdj(fig, fig_lrPadding, fig_hspace, fig_top, fig_bottom):
    fig.tight_layout()

    fig.subplots_adjust(left=fig_lrPadding)
    fig.subplots_adjust(right=1-fig_lrPadding)

    fig.subplots_adjust(hspace=fig_hspace)
    fig.subplots_adjust(top=fig_top)
    fig.subplots_adjust(bottom=fig_bottom)

###############################################################################


