文件夹下面有两份.rdl文件生成的.v和.vh文件，文件名与.rdl文件名一致
.vh文件记录了不同寄存器在module中的地址
.v文件包括:{  
    1、module standard ports
    2、external ports(if needed)
    3、internal fields ports

    4、parameter definitnion(ADDR_WIDTH、DATA_WIDTH、Internal register number N、External module number M)
    5、wire definition
    6、decode logic(value defined by .vh)

    7、state machine module(general template which is described in statemachine.v)

    8、reg&field instance
    9、external logic(if needed)

    10、output split mux
    11、output value
}