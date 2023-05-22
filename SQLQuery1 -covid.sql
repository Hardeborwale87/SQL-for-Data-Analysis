select * 
from portfolio_project..CovidDeaths
order by 3,4

--select * 
--from portfolio_project..CovidVaccinations
--order by 3,4

-- Select data to be used

Select location, date, total_cases, new_cases, total_deaths, population
from portfolio_project..CovidDeaths
order by 1,2

-- Looking at Toatal cases vs Total Deaths
-- Show likelihood of dying in your country
Select location, date, total_cases, total_deaths, (total_deaths/total_cases) * 100 as death_percentage
from portfolio_project..CovidDeaths
where location like '%nigeria%'
order by 1,2

-- Looking at Total cases vs Population
-- Show what percentage of population got covid

Select location, date, population, total_cases, (total_cases/population) * 100 as death_percentage
from portfolio_project..CovidDeaths
where location like '%nigeria%'
order by 1,2

-- Looking at countriest with highest infection rate to population

Select location, population, MAX(total_cases) as HighestInfection, MAX((total_cases/population)) * 100 as PercentInfectedPopulation
from portfolio_project..CovidDeaths
--where location like '%nigeria%'
Group by location, population
order by PercentInfectedPopulation desc

--Showing countries with highest death count per population

Select location, MAX(cast(total_deaths as int)) as HighestDeath
from portfolio_project..CovidDeaths
--where location like '%belgium%'
WHere continent is not null
Group by location
order by HighestDeath desc

-- LET'S BREAK THINGS DOWN BY CONTINENT

Select location, MAX(cast(total_deaths as int)) as HighestDeath
from portfolio_project..CovidDeaths
--where location like '%belgium%'
WHere continent is null
Group by location
order by HighestDeath desc

-- Showing continents with the highest death count per population

Select continent, MAX(cast(total_deaths as int)) as HighestDeath
from portfolio_project..CovidDeaths
--where location like '%belgium%'
WHere continent is not null
Group by continent
order by HighestDeath desc

-- GLOBAL NUMBERS

Select SUM(new_cases), SUM(cast(new_deaths as int)), SUM(cast(new_deaths as int)) / SUM(new_cases) * 100 as deathPercentage
from portfolio_project..CovidDeaths
--where location like '%nigeria%'
where continent is not null
--Group by date
order by 1,2


-- Looking at Total Population vs Vaccinations

select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
	SUM(CONVERT(int, new_vaccinations)) OVER (Partition by dea.location Order by dea.location,dea.date) AS RollingPeopleVaccinated
from portfolio_project..CovidDeaths dea
JOIN portfolio_project..CovidVaccinations vac
	ON dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null
order by 2,3


-- USING CTE

WITH PopvsVac (continent, location, date, population, new_vaccinations, RollingPeopleVaccinated)
as
(
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
	SUM(CONVERT(int, new_vaccinations)) OVER (Partition by dea.location Order by dea.location,dea.date) AS RollingPeopleVaccinated
from portfolio_project..CovidDeaths dea
JOIN portfolio_project..CovidVaccinations vac
	ON dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null
--order by 2,3
)
Select *, (RollingPeopleVaccinated/population)*100 AS PopulationVaccinatedPeople
From PopvsVac



-- TEMP TABLE

-- Drop Table if exists

Create Table #PercentPopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Dtae datetime,
Population numeric,
New_vaccinations numeric,
RollingPeopleVaccinated numeric
)

Insert into #PercentPopulationVaccinated
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
	SUM(CONVERT(int, new_vaccinations)) OVER (Partition by dea.location Order by dea.location,dea.date) AS RollingPeopleVaccinated
from portfolio_project..CovidDeaths dea
JOIN portfolio_project..CovidVaccinations vac
	ON dea.location = vac.location
	and dea.date = vac.date
--where dea.continent is not null

Select *, (RollingPeopleVaccinated/population)*100 AS PopulationVaccinatedPeople
From #PercentPopulationVaccinated


-- Creating view to store data for later visualizations

Create View PercentPopulationVaccinated as
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
	SUM(CONVERT(int, new_vaccinations)) OVER (Partition by dea.location Order by dea.location,dea.date) AS RollingPeopleVaccinated
from portfolio_project..CovidDeaths dea
JOIN portfolio_project..CovidVaccinations vac
	ON dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null

Select * 
FRom PercentPopulationVaccinated