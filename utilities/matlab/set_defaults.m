function set_defaults()
% set_default():默认绘图全局设置
% Input : None
% Output: None
    % 字体设置
    set(0, 'DefaultAxesFontName', 'Arial', ...
           'DefaultTextFontName', 'Arial', ...
           'DefaultAxesFontSize', 10, ...
           'DefaultTextFontSize', 10);
    
    % 线宽与标记
    set(0, 'DefaultLineLineWidth', 1.8, ...
           'DefaultStairLineWidth', 1.8, ...
           'DefaultStemLineWidth', 1.2, ...
           'DefaultErrorBarLineWidth', 1.2, ...
           'DefaultScatterMarkerSize', 8);  % 点直径(点)
    
    % 坐标轴与框线
    set(0, 'DefaultAxesLineWidth', 1.2, ...
           'DefaultAxesBox', 'on', ...
           'DefaultAxesXGrid', 'off', ...
           'DefaultAxesYGrid', 'off', ...
           'DefaultAxesGridLineWidth', 1.0);
    
    % 颜色与渲染
    set(0, 'DefaultAxesColorOrder', colorbrewer('qual', 'Set1', 8), ...
           'DefaultFigureColor', 'white', ...
           'DefaultFigureInvertHardcopy', 'off');
    
    % 布局优化
    set(0, 'DefaultAxesLooseInset', [0.05, 0.05, 0.05, 0.05]); % 减少白边
end
