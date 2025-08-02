% utilities/matlab/export_tools/set_crop_margins.m
function set_crop_margins(fig, margins)
% 精确控制图像边界裁剪
% 输入:
%   fig - 图形句柄
%   margins - 边距 [左,下,右,上] (mm)

% 转换为厘米 (MATLAB使用厘米单位)
margins_cm = margins / 10;

% 获取当前设置
original_units = get(fig, 'Units');
set(fig, 'Units', 'centimeters');
pos = get(fig, 'Position');

% 计算新位置
new_width = pos(3) - margins_cm(1) - margins_cm(3);
new_height = pos(4) - margins_cm(2) - margins_cm(4);
new_pos = [margins_cm(1), margins_cm(2), new_width, new_height];

% 应用新设置
set(fig, 'Position', new_pos);
set(fig, 'Units', original_units);

% 更新PaperPosition
set(fig, 'PaperPositionMode', 'auto');
paper_pos = get(fig, 'PaperPosition');
set(fig, 'PaperPosition', [0 0 paper_pos(3) paper_pos(4)]);
end
