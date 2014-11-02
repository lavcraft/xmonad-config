Config { font = "-*-Fixed-Bold-R-Normal-*-13-*-*-*-*-*-*-*"
    bgColor = "#000000",
    fgColor = "#ffffff",
    position = Static { xpos = 0, ypos = 0, width = 1920, height = 16 },
    lowerOnStart = True,
    commands = [
	     Run Weather "UUDD" ["-t","<station>: <tempC>C","-L","18","-H","25","--normal","green","--high","red","--low","lightblue"] 36000
        ,Run Memory ["-t","Mem: <usedratio>%","-H","8192","-L","4096","-h","#FFB6B0","-l","#CEFFAC","-n","#FFFFCC"] 10        
        ,Run Network "enp6s0" ["-t","Net: <rx>, <tx>","-H","200","-L","10","-h","#FFB6B0","-l","#CEFFAC","-n","#FFFFCC"] 10
        ,Run Date "%Y.%m.%d %H:%M:%S" "date" 10
        ,Run MultiCpu [ "--template" , "Cpu: <total0>%_<total1>%_<total2>%_<total3>%_<total4>%_<total5>%_<total5>%_<total5>"
            , "--Low"      , "50"         -- units: %
            , "--High"     , "85"         -- units: %
            , "--low"      , "gray"
            , "--normal"   , "darkorange"
            , "--high"     , "darkred"
        ] 10
        ,Run PipeReader "/tmp/.volume-pipe" "vol"
        ,Run StdinReader
    ],
    sepChar = "%",
    alignSep = "}{",
    template = "%StdinReader% }{ %vol% %multicpu% | %memory%  | %enp6s0% | %UUDD% | <fc=#FFFFCC>%date%</fc>   "
}
