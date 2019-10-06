# Author: Jennifer Cafiero
# CS306 Homework 1, Problem 4
# I pledge my honor that I have abided by the Stevens Honor System

from operator import itemgetter

'''def split_by_2(msg):
    charlist = []
    while msg:
        charlist.append(msg[:2])
        msg = msg[2:]
    return charlist

def sort_char_freq(chars):
    d = {}
    for char in chars:
        keys = d.keys()
        if char in keys:
            d[char] += 1
        else:
            d[char] = 1
    return sorted(d.items(), key=itemgetter(1))'''

def hex_to_bin(msg):
    int_msg = int(msg, 16)
    bin_msg = format(int_msg, '0>42b')
    return bin_msg

def bin_to_hex(msg):
    int_msg = int(msg, 2)
    return hex(int_msg)

def scrape_hex(msg):
    return str(msg)


def xor(x, y):
    return '{1:0{0}b}'.format(len(x), int(x, 2) ^ int(y, 2))

def main():
    transmitted = ['2d0a0612061b0944000d161f0c1746430c0f0952181b004c1311080b4e07494852',
                   '200a054626550d051a48170e041d011a001b470204061309020005164e15484f44',
                   '3818101500180b441b06004b11104c064f1e0616411d064c161b1b04071d460101',
                   '200e0c4618104e071506450604124443091b09520e125522081f061c4e1d4e5601',
                   '304f1d091f104e0a1b48161f101d440d1b4e04130f5407090010491b061a520101',
                   '2d0714124f020111180c450900595016061a02520419170d1306081c1d1a4f4601',
                   '351a160d061917443b3c354b0c0a01130a1c01170200191541070c0c1b01440101',
                   '3d0611081b55200d1f07164b161858431b0602000454020d1254084f0d12554249',
                   '340e0c040a550c1100482c4b0110450d1b4e1713185414181511071b071c4f0101',
                   '2e0a5515071a1b081048170e04154d1a4f020e0115111b4c151b492107184e5201',
                   '370e1d4618104e05060d450f0a104f044f080e1c04540205151c061a1a5349484c']
    bin_messages = []
    xor_msgs = []
    for message in transmitted:
        # chars = split_by_2(message)
        # sortlist = sort_char_freq(chars)
        bin_messages.append(hex_to_bin(message))
    print(bin_messages, '\n')
    for i in range(1, len(bin_messages)):
        xor_msgs.append(xor(bin_messages[0], bin_messages[i]))
    print(xor_msgs,'\n')

    for msg in xor_msgs:
        print(bin_to_hex(msg))
        
        
    return 1

if __name__ == "__main__":
    main()
