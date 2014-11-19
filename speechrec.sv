// speechrec.sv
// 16 November 11
// strisorus@hmc.edu
// 
// Receives an audio signal via SPI and compares it to audio signals stored in memory

module speechrec(input  logic       clk, sck, sdi, ss,
                 output logic       sdo,
                 output logic [7:0] led);

    // Extra signals
    logic input_ready;     // Keep track of whether or not input audio has been
                           // received and processing is ready to begin
    logic transmit_ready;  // Keep track of whether or not processing is complete
                           // and data is ready to be sent back to master
    logic [7:0]     data;  // Temporary data to send to master
    //logic [39999:0] audio; // Input audio data
    logic [7:0]     audio; // TODO: Received data for testing
    //logic [15:0]    count; // Keep count of bits of data received
    logic [3:0]     count; // TODO: Shortened counter for testing

    // State signals
    typedef enum logic [2:0] {S0=3'b000, S1=3'b001, S2=3'b010, S3=3'b011, S4=3'b100} statetype;
    statetype state, nextstate;

    // State register
    always_ff @(posedge clk)
        state <= nextstate;

    // Next state logic
    always_comb
        case(state)
            S0: nextstate =             ss ? S1 : S0; // S0: Wait for master to send input audio
            S1: nextstate =    input_ready ? S2 : S1; // S1: Receive the audio
            S2: nextstate = transmit_ready ? S3 : S2; // S2: Process the audio
            S3: nextstate =             ss ? S4 : S3; // S3: Wait for master to be ready
            S4: nextstate = transmit_ready ? S4 : S0; // S4: Transmit the audio
            default:
        endcase
    end

    // Output logic
    always_comb begin
        //input_ready =    (count == 16'h9C40);  // Stop when we have received 5000 1-byte samples
        input_ready    = (count = 4'b1000);    // TODO: Shortened counter for testing
        transmit_ready = (data != 7'b0000000); // Ready to transmit when there is data to send
    end

    receiver    spi_receive(sck, sdi, ss, led);
    transmitter spi_send(sck, data, transmit_ready, sdo);
    processor   process_audio(audio, data);

endmodule


module spi_receive(input  logic       sck, sdi, en,
                   output logic [3:0] count,
                   output logic [7:0] audio,
                   output logic [7:0] led);

    // Only receive if enable is high
    always_ff @(posedge sck)
        if (en) begin
            audio <= {audio[6:0], sdi};
            count <= count + 1;
        end

    // TODO: For debugging, write the received data to the LED bar
    assign led = audio;

endmodule


module spi_send(input  logic       sck, en,
                input  logic [7:0] data,
                output logic       sdo);

    // Only transmit if enable is high
    always_ff @(negedge sck)
        if (en) begin    
            sdo  <= data[7];
            data <= {data[6:0], 0};
        end

endmodule


module process_audio(//input  logic [39999:0] audio,
                     input  logic     [7:0] audio,
                     output logic     [7:0] data);
    
    // TODO: Audio processing algorithm will go here
    // TODO: For now, write the received char back to data
    assign data = audio;
endmodule