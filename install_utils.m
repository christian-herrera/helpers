% Ejecutar utilizando:
%
%   websave("install_utils.m", "https://helpers.christianherrera.com.ar/install_utils.m");
%   run("install_utils.m");

clc; clear;

release = webread("https://api.github.com/repos/christian-herrera/matlab/releases/latest");

% Variables
tag = release.tag_name(2:end);              % '1.0.0'
file_zip = release.tag_name + ".zip";       % 'v1.0.0.zip'
folder_name = "matlab-" + tag;              % 'matlab-1.0.0'
destino = fullfile(userpath, "Utils");      % 'C:\Users\chris\Documents\MATLAB\Utils'
url_zip = "https://github.com/christian-herrera/matlab/archive/refs/tags/" + file_zip;

% Descarga y descomprime
unzip(url_zip)

% Elimina la versión previa
if exist(destino,'dir')
    rmpath(genpath(destino));
    rmdir(destino, 's');
end

% Copia al path de matlab
[status, msh] = copyfile(fullfile(folder_name, "Utils"), destino);

if(status)
    fprintf("\n<strong>Repositorio instalado en la máquina con éxito!</strong>\n\n");
    addpath(genpath(destino));
    savepath;
else
    fprintf("\n<strong>Error en la copia del archivo!</strong>\n\n");
end

pause(1);
rmdir(folder_name, 's');