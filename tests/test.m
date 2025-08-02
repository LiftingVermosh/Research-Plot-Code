% 测试函数
clc;
clear;
close all;

set_defaults();

x = 0:0.1*pi:2*pi;
y = sin(x) + rand(1);

h = figure();
plot(x, y, '-o');
xlim([min(x) - 0.1 * max(x), 1.1 * max(x)])
ylim([min(y) - 0.1 * max(y), 1.1 * max(y)])

test_export_tools();