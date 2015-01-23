wifi.setmode(wifi.SOFTAP);
wifi.ap.config({ssid="wifi-iot-node-"..wifi.ap.getmac(),pwd="12345678"});
--print("AP mdoe, IP is "..wifi.ap.getip())

uart.setup(0,9600,8,0,1,0)
sv=net.createServer(net.TCP, 60)
global_c = nil         
sv:listen(9999,        
        function(c)
            if global_c ~= nil then
                global_c:close()
            end
            global_c = c
            c:on("receive",
            function(sck, pl)
                uart.write(0,pl)
            end)       
        end)

uart.on("data",0, 
        function(data)
            --uart.write(0,data)        
            if (global_c ~= nil) then
                global_c:send(data)

            end    
        end, 
        0) 



