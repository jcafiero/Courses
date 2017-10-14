def GCcontent4(DNA):
    '''Computes the GC content of a DNA string of length 4.'''
    counter=0
    if DNA[0]=='G' or DNA[0]=='C':
        counter += 1
    if DNA[1]=='G' or DNA[1]=='C':
        counter += 1
    if DNA[2]=='G' or DNA[2]=='C':
        counter += 1
    if DNA[3]=='G' or DNA[3]=='C':
        counter += 1
    return counter/4.0

def DNAtoRNA(DNA):
    '''Returns the equivalent RNA for the given DNA string.'''
    RNA=''
    for nuc in DNA:
        if nuc=='T':
            RNA += 'U'
        else:
            RNA += nuc
    return RNA
