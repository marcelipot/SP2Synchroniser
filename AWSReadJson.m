function dataRaw = AWSReadJson(fileName);

dataRaw = jsondecode(fileread(fileName));