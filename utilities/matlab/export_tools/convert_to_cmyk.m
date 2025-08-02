% utilities/matlab/export_tools/convert_to_cmyk.m
function convert_to_cmyk(filename)
% 使用Ghostscript将RGB PDF/EPS转换为CMYK
% 需要安装Ghostscript并添加到系统路径

[filepath, name, ext] = fileparts(filename);
output_file = fullfile(filepath, [name '_cmyk' ext]);

% 检查文件类型
if ~ismember(lower(ext), {'.pdf', '.eps'})
    error('CMYK转换仅支持PDF/EPS格式');
end

% 构造Ghostscript命令
cmd = sprintf('gswin64c -o "%s" -sDEVICE=pdfwrite ', output_file);
cmd = [cmd '-sColorConversionStrategy=CMYK '];
cmd = [cmd '-dProcessColorModel=/DeviceCMYK '];
cmd = [cmd '-dCompatibilityLevel=1.4 "%s"'];

% 执行转换
[status, result] = system(sprintf(cmd, filename));

if status == 0
    movefile(output_file, filename, 'f');
    fprintf('成功转换为CMYK: %s\n', filename);
else
    error('CMYK转换失败: %s', result);
end
end
