# Enter your code here. Read input from STDIN. Print output to STDOUT
class Trade:
    def __init__(self, TradeDate,Instrument,SidelsBuy,Quantity,Price):
        
        self.TradeDate = TradeDate
        self.Instrument = Instrument
        self.SidelsBuy = SidelsBuy
        self.Quantity = Quantity
        self.Price = Price

def total_financeiro(trades):
    total_by_trade = []
    for i in trades:
        if i.SidelsBuy == True:
            v = -i.Price*i.Quantity
        else:
            v = i.Price*i.Quantity
        total_by_trade.append([i.TradeDate, v])
    d = {}
    for date, value in total_by_trade:
        d[date] = d.get(date, 0) + value
    #return total_by_trade
    
    print(list(d.items()))
    #return(list(d.items()))    


def posicao(trades, date):
    total_by_inst = []
    trades.sort(key=lambda x: x.TradeDate)
    for i in trades:
        if i.TradeDate > date:
            break
        if i.SidelsBuy == True:
            q = i.Quantity
        else:
            q = -i.Quantity
        total_by_inst.append([i.Instrument, q])
        
    p = {}
    for inst, qnt in total_by_inst:
        p[inst] = p.get(inst, 0) + qnt
    p = {k:v for k, v in p.items() if v != 0}
    #return total_by_inst

    print(list(p.items()))
