import DelimitedFiles
import InteractiveViz
import Changepoints


file = "linearity_1_40_05.txt";

data = readdlm("process\\$file", ',', Float64, header=false)

iplot(data[:,1], data[:,2])