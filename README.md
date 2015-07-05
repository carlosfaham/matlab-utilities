# matlab-utilities
Useful Matlab utilities

A collection of Matlab utilities that make life easier.

   * **mousecut.m** might be the most useful one in exploratory data analysis - it lets you select a subset of the data by drawing a convex hull (e.g. mishapen polygon) in a plot.
   * **cfft.m and **icfft.m** give you nice outputs (shifted to be symmetrical about 0, only one cycle, output frequency vector, etc.) for Fourier and inverse Fourier transformations.
   * **myfigview.m** and **saveme.m** format the plot nicely and saves it in different formats.
   * **deletelastchild.m** (credit to Rick Gaitskell) is an awesome function to delete the last (or nth-from-last) plotted curve on a figure.
   * **linfit.m** is a simple linear fit that incorporates errorbars in the data points, and correspondingly outputs the uncertainties in regression coefficients. It's not vectorized but it's fast enough :)
   
