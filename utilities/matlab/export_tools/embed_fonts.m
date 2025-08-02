% utilities/matlab/export_tools/embed_fonts.m
function embed_fonts(fig, font_mode)
% 确保字体正确嵌入或转换为路径
% 输入:
%   fig - 图形句柄
%   font_mode - 字体处理模式 ('fixed' 或 'scaled')

% 设置渲染器
set(fig, 'Renderer', 'painters');

% 获取所有文本对象
text_objs = findall(fig, 'Type', 'text');

% 根据模式处理字体
switch lower(font_mode)
    case 'fixed'
        set(text_objs, 'FontUnits', 'points');
    case 'scaled'
        set(text_objs, 'FontUnits', 'normalized');
end
drawnow; % 立即应用更改
end
