library(quantmod)
library(ggplot2)


####Petrobras
petr <- getSymbols("petr4.sa", src = "yahoo", from = "2013-01-01", 
                  to = "2020-12-01", auto.assign = FALSE)
head(petr)
tail(petr)
summary(petr)
str(petr)

ggplot(petr, aes(x = index(petr), y = petr[,6])) + geom_line(color = "darkblue") +
  ggtitle("Série de preços da PETR4") +
  xlab("Data") + ylab("Preço ($)") + theme(plot.title = element_text(hjust = 0.5)) + 
  scale_x_date(date_labels = "%b %y", date_breaks = "6 months")


####ITAU

itub <- getSymbols("itub4.sa", src = "yahoo", from = "2013-01-01", 
                  to = "2020-12-01", auto.assign = FALSE)
head(itub)
tail(itub)
summary(itub)
str(itub)

ggplot(itub, aes(x = index(itub), y = itub[,6])) + geom_line(color = "darkblue") +
  ggtitle("Série de preços da ITUB4") +
  xlab("Data") + ylab("Preço ($)") + theme(plot.title = element_text(hjust = 0.5)) + 
  scale_x_date(date_labels = "%b %y", date_breaks = "6 months")

######EMBRAER

embr <- getSymbols("embr3.sa", src = "yahoo", from = "2013-01-01", 
                   to = "2020-12-01", auto.assign = FALSE)
head(embr)
tail(embr)
summary(embr)
str(embr)

ggplot(embr, aes(x = index(embr), y = embr[,6])) + geom_line(color = "darkblue") +
  ggtitle("Série de preços da EMBR4") +
  xlab("Data") + ylab("Preço ($)") + theme(plot.title = element_text(hjust = 0.5)) + 
  scale_x_date(date_labels = "%b %y", date_breaks = "6 months")


######Magazine Luiza
mglu <- getSymbols("mglu3.sa", src = "yahoo", from = "2013-01-01", 
                   to = "2020-12-01", auto.assign = FALSE)
head(mglu)
tail(mglu)
summary(mglu)
str(mglu)

ggplot(mglu, aes(x = index(mglu), y = mglu[,6])) + geom_line(color = "darkblue") +
  ggtitle("Série de preços da MGLU4") +
  xlab("Data") + ylab("Preço ($)") + theme(plot.title = element_text(hjust = 0.5)) + 
  scale_x_date(date_labels = "%b %y", date_breaks = "6 months")

########RETORNOS


ret_petr<- yearlyReturn(petr)
ret_itub<- yearlyReturn(itub)
ret_embr<- yearlyReturn(embr)
ret_mglu<- yearlyReturn(mglu)

retornos <- cbind(ret_petr, ret_itub, ret_embr, ret_mglu)

retorno_medio <- rbind(mean(retornos[,1]), mean(retornos[,2]), mean(retornos[,3]), mean(retornos[,4]))

ativos <- c('PETR4', 'ITUB4', 'EMBR3', 'MGLU4')

rownames(retorno_medio) <- ativos

#####Matriz de Covariância

mat_cov <- cov(retornos)

rownames(mat_cov) <- ativos
colnames(mat_cov) <- ativos

mat_cov

####Montando carteira de investimentos

library(IntroCompFinR)
rf <- 0.02

short_selling <- F

invest_portfolio <- tangency.portfolio(retorno_medio, mat_cov, 
                   rf, shorts = short_selling)
invest_portfolio

ativos

# Calculo da carteira com a menor risco possÃ­vel
carteira_min_risco <- globalMin.portfolio(retorno_medio, mat_cov, shorts = short_selling)

carteira_min_risco

# compute portfolio frontier
fronteira_eficiente <- efficient.frontier(retorno_medio, mat_cov, nport = 40, shorts = short_selling)

fronteira_eficiente

attributes(fronteira_eficiente)

# VisualizaÃ§ao da saida

plot(fronteira_eficiente, plot.assets=TRUE, col="blue", pch=16)

points(carteira_min_risco$sd, carteira_min_risco$er, col="green", pch=10, cex=2)
points(invest_portfolio$sd, invest_portfolio$er, col="red", pch=10, cex=2)

text(carteira_min_risco$sd, carteira_min_risco$er, labels="Risco Minimo", pos=2)
text(invest_portfolio$sd, invest_portfolio$er, labels="Carteira Eficiente", pos=2)

tangente <- (invest_portfolio$er - rf)/invest_portfolio$sd
abline(a = rf, b=tangente, col="green", lwd=2)
