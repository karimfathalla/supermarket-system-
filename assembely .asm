include 'emu8086.inc'

org 100h
                       
DEFINE_SCAN_NUM
DEFINE_PRINT_STRING
DEFINE_PRINT_NUM
DEFINE_PRINT_NUM_UNS 
input:
    lea si, message1    ;we load message to the si regester to display it using print_string                      
    call print_string   ;we store the id in selected_id variable
    mov si,0      
    call scan_num           
    mov selected_id, cl     
       PRINT 0AH
   
    cmp selected_id, 0   ;when user ends the input 
    je calculate_total      

    
    lea si, products        
    lea di, prices         
    mov cx, 3  
                          
search_loop:                 ;we enter loop that compare the id of stored ids                             
    mov al, [si]             ; when we find the product we jump to found_product and if we dont we loop back the number of stored ids                             ;when we finish the products number we
    cmp al, selected_id   
    je found_product      

    add si, 1             
    add di, 2             
    loop search_loop      

    lea si, message3     
    call print_string
    mov si,0    
    jmp input

found_product:
    
    mov ax, [di]            
    add total_price, ax     
    lea si, message4        
    call print_string
     
    mov si, 0      
    jmp input       

calculate_total:   ; adding the price that matches the number of element from array prices 
         PRINT 0AH
    lea si, message2 
    call print_string 
    Print 0Ah
    mov si,0
    mov ax, total_price   
    call print_num 
    PRINT 0AH       

ret      


products db 1, 2, 3         
prices dw 100, 200, 300     
          

message1 db 'Enter product ID (0 to finish): ', 0
message2 db 'Total price: ', 0   
message3 db 'Invalid product ID! Try again.', 0
message4 db 'Product added to cart!', 0


selected_id db 0            
total_price dw 0

