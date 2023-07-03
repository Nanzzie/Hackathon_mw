% MATLAB script
function callPython(onFile)
    pythonScriptPath = 'test\Scheduling\scheduler.py ';
    system(['python ', pythonScriptPath, onFile]);
end