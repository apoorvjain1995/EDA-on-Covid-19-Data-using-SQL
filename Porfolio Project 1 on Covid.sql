--Exploring The data
SELECT * FROM [Portfolio Project]..CovidDeaths$ WHERE continent IS NOT NULL ORDER BY 3,4;
--SELECT * FROM [Portfolio Project]..CovidVaccinations$ ORDER BY 3,4;



SELECT Location,date,total_cases,new_cases,total_deaths,population
FROM [Portfolio Project]..CovidDeaths$
WHERE continent IS NOT NULL
ORDER BY 1,2;


--Looking at total cases VS total deaths
--Shows liklihood of dying if you contract covid in India
SELECT Location,date,total_cases,total_deaths,((total_deaths/total_cases)*100) As "Death Rate"
FROM [Portfolio Project]..CovidDeaths$
WHERE location LIKE 'India' AND continent IS NOT NULL
ORDER BY 1,2;


--Looking at the Total Cases VS Total Population for India
SELECT Location,date,total_cases,population,((total_cases/population)*100) AS 'Infection Rate'
FROM [Portfolio Project]..CovidDeaths$
--WHERE location LIKE 'India'
WHERE continent IS NOT NULL
ORDER BY 1,2;


--Looking at countries with Highest Infection Rate compared to popuation
SELECT Location,population,MAX(total_cases) AS 'Highest Infection Count',MAX((total_cases/population))*100 AS 'Percent of Population Infected'
FROM [Portfolio Project]..CovidDeaths$
--WHERE location LIKE 'India'
WHERE continent IS NOT NULL
GROUP BY location,population
ORDER BY 'Percent of Population Infected' DESC;


--Breaking things down by continent and showing continents with highest death count
SELECT continent,MAX(CAST(total_deaths AS int)) AS TotalDeathCount
FROM [Portfolio Project]..CovidDeaths$
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY TotalDeathCount DESC;



--Showing Countries with Highest Death Count PER Population
SELECT location,MAX(CAST(total_deaths AS int)) AS TotalDeathCount
FROM [Portfolio Project]..CovidDeaths$
WHERE continent IS NULL
GROUP BY location
ORDER BY TotalDeathCount DESC;


--GLOBAL NUMBERS
SELECT date, SUM(new_cases) AS Total_Cases, SUM(CAST(new_deaths AS int)) AS TotalDeaths, SUM(CAST(new_deaths AS int))/SUM(new_cases)*100 AS 'Death Percentage'
FROM [Portfolio Project]..CovidDeaths$
WHERE continent IS NOT NULL
GROUP BY date
ORDER BY 1,2;

--Looking at Total Population VS Total Vaccination
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,  
SUM(CAST(vac.new_vaccinations AS INT)) OVER(PARTITION BY dea.location ORDER BY dea.location,dea.date) AS RollingPeopleVaccinated
FROM [Portfolio Project]..CovidVaccinations$ vac
JOIN [Portfolio Project]..CovidDeaths$ dea
ON dea.location=vac.location
AND dea.date=vac.date
WHERE dea.continent IS NOT NULL
ORDER BY 2,3;

--Using CTE to perform calculations on Window function data
WITH PopVSVac (Continent, Location, Date, Population, New_Vaccinations, RollingPeopleVaccinated)
as 
(
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,  
SUM(CAST(vac.new_vaccinations AS INT)) OVER(PARTITION BY dea.location ORDER BY dea.location,dea.date) AS RollingPeopleVaccinated
FROM [Portfolio Project]..CovidVaccinations$ vac
JOIN [Portfolio Project]..CovidDeaths$ dea
ON dea.location=vac.location
AND dea.date=vac.date
WHERE dea.continent IS NOT NULL
--ORDER BY 2,3
)
SELECT *,(RollingPeopleVaccinated/Population)*100 FROM PopVSVac;

-- Doing the same as above using temp table
Create Table #PercentPopulationVaccinated
(
continent nvarchar(255),
location nvarchar(255),
date datetime,
population numeric,
New_Vaccinations numeric,
RollingPeopleVaccinated numeric
)

INSERT INTO #PercentPopulationVaccinated
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,  
SUM(CAST(vac.new_vaccinations AS INT)) OVER(PARTITION BY dea.location ORDER BY dea.location,dea.date) AS RollingPeopleVaccinated
FROM [Portfolio Project]..CovidVaccinations$ vac
JOIN [Portfolio Project]..CovidDeaths$ dea
ON dea.location=vac.location
AND dea.date=vac.date
WHERE dea.continent IS NOT NULL
--ORDER BY 2,3

SELECT *,(RollingPeopleVaccinated/Population)*100 FROM #PercentPopulationVaccinated;

--Creating view to store data for later visualisations
CREATE VIEW PercentPopulationVaccinated AS 
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,  
SUM(CAST(vac.new_vaccinations AS INT)) OVER(PARTITION BY dea.location ORDER BY dea.location,dea.date) AS RollingPeopleVaccinated
FROM [Portfolio Project]..CovidVaccinations$ vac
JOIN [Portfolio Project]..CovidDeaths$ dea
ON dea.location=vac.location
AND dea.date=vac.date
WHERE dea.continent IS NOT NULL
--ORDER BY 2,3

SELECT * FROM PercentPopulationVaccinated;
