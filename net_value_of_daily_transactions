class Transaction:
    
    def __init__(self, date, ticker, purchase,p,q):
        
        self.date = date
        self.ticker = ticker
        self.purchase = purchase
        self.p = p
        self.q = q
        


from itertools import combinations
from itertools import groupby
def tot_fin(trades): #list of objects 'Transactions' goes in the argument 'trades'
    #d = 0 #initial value of balance for each day
    tot_by_trade = [] #list where the net values of negotiations will get into together with the date of negotiations
    for i in trades:
        if i.purchase == True:
            v = -i.p*i.q
        else:
            v = i.p*i.q
        tot_by_trade.append([i.date, v])
    d = {}

    for date, value in tot_by_trade:
        d[date] = d.get(date, 0) + value
    return (list(d.items()))
