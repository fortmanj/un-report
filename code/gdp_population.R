library(tidyverse)

gapminder_1997 <-read_csv("gapminder_1997.csv")

ggplot(data=gapminder_1997) +
  aes(x= gdpPercap) + 
  labs (x= "GDP Per Capita") +
  aes (y= lifeExp) +
  labs (y= "Life Expectancy") +
  geom_point () +
  labs (title = "Do people in wealthy countries live longer?") +
  aes (color= continent) +
  scale_color_brewer(palette = "Set1") +
  aes (size= pop/1000000) +
  labs (size= "Population (in millions)")

ggplot (data= gapminder_1997) +
  aes (x = gdpPercap, y=lifeExp, color= continent, size= pop/1000000)+
  geom_point()+
  labs( x= "GDP Per Capita", y= "Life Expectancy", 
        title= "Do people in wealthy countries live longer?", 
        size= "Population (in millions)") + 
        scale_color_brewer(palette= "Set1")


