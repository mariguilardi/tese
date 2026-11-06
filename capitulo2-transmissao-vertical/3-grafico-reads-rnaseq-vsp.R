# instalar pacotes
#install.packages("tidyverse")
#install.packages("ggbreak")

# importar pacotes
library(tidyverse)
library(ggbreak) 

# associando dados de números de reads SNC de RNA-Seq a variável
snc <- read.table("snc.depth", sep = "\t", header = FALSE, 
                 col.names = c("refSeq", "nucleotide_pos", 
                               "coverage_depth"))

head(snc)

# associando dados de números de reads feto de RNA-Seq a variável
feto <- read.table("feto.depth", sep = "\t", header = FALSE, 
                 col.names = c("refSeq", "nucleotide_pos", 
                               "coverage_depth"))

# associando dados de número de reads feto de VSP2 a variável
vsp <- read.table("vsp2.depth", sep = "\t", header = FALSE, 
                  col.names = c("refSeq", "nucleotide_pos", 
                                "coverage_depth"))

# combinar dados e criar coluna com nome do pool
data <- bind_rows(
  mutate(snc, pool = "SNC"),
  mutate(feto, pool = "Feto"),
  mutate(vsp, pool = "VSP2"))

# ver resultado da tabela final
head(data)
glimpse(data)

# gráfico do número de reads por método (RNA-Seq e VSP2)
ggplot(data, aes(x = nucleotide_pos, y = coverage_depth, fill = pool)) +
  geom_col() +
  xlab("Genome position") +
  ylab("Number of Reads") +
  scale_x_continuous(expand = c(0, 0), breaks = seq(0,13000, by = 2500)) +
  scale_y_continuous(expand = c(0, 0)) +
  scale_y_break(breaks=c(20, 600), scales = 1) +
  theme_classic() +
  scale_fill_discrete(name = "Sample", 
                      labels = c("CNS", "Fetus RNA-Seq",
                                 "Fetus VSP2")) +
  theme(panel.border = element_rect(colour = "black", fill=NA, 
                                    linewidth=0.5),
        axis.text.x = element_text(angle = 90),
        axis.text.y.right = element_blank(),
        axis.line.y.right = element_blank(),
        axis.ticks.y.right = element_blank()) 
