import React, { useEffect, useState } from "react";
import { Tab, Tabs, TabList, TabPanel } from "react-tabs";
import TableTemplate from "../UI/TableTemplate";
import "react-tabs/style/react-tabs.css"; // import the react-tabs default CSS
import PageResult from "../PageResult/PageResult";
import { NavLink, useNavigate } from "react-router-dom";
import CreateEvent from "../CreateEvent/CreateEvent";
import RegisterUser from "../RegisterUser/RegisterUser";
import useAuth from "../hooks/useAuth";
import axios from "axios";
import CreateEventOrginizer from "../CreateEvent/CreateEventOrginizer";
import { useLocation } from "react-router-dom";

const customStyles = {
  // add custom styles for tabs
  tabList: {
    display: "flex",
    justifyContent: "center",
    margin: 0,
    padding: 0,
  },
  tab: {
    padding: "10px 20px",
    marginRight: "15px",
    cursor: "pointer",
    fontWeight: 600,
  },
};

function downloadCSV(data, title) {
  const filterDownloaded = data.filter((el) => el.competition_title === title);

  console.log(data, filterDownloaded);
  const csv = filterDownloaded
    .map((item) => Object.values(item).join(","))
    .join("\n");

  const anchor = document.createElement("a");
  const blob = new Blob([csv], { type: "text/csv" });
  anchor.href = URL.createObjectURL(blob);
  anchor.download = "data.csv";

  document.body.appendChild(anchor);
  anchor.click();
  document.body.removeChild(anchor);
}

const TabsPanel = (props) => {
  const { isLoggedIn, userData } = useAuth();
  const [id, setId] = useState(null);
  const location = useLocation();

  useEffect(() => {
    const searchParams = new URLSearchParams(location.search);
    const competitionId = searchParams.get("id");
    setId(competitionId);
  }, [location]);

  const navigate = useNavigate();
  const [data, setData] = useState([]);
  const [data1, setData1] = useState([]);
  const [title, setTitle] = useState();

  const [displayResult, setShowResult] = useState(true);
  const [showDancingClub, setShowDancingClub] = useState(false);
  const [competitionId, setCompetitionId] = useState();
  const [competitionDancers, setCompetitionDancers] = useState(false);
  const [competitionDancersData, setCompetitionDancersData] = useState([]);
  const [data2, setData2] = useState([]);

  const handleGetDancingData = async () => {
    try {
      const response = await axios.get("http://localhost:8888/club/index.php");

      setData(response.data.message ? [{ error: "No data" }] : response.data);
    } catch (error) {
      console.error(error);
    }
  };
  useEffect(() => {
    if (id == 2) {
      setShowResult(true);
    }
  }, [id]);
  const closeTab = () => {
    setShowResult(true);
    setShowDancingClub(false);
  };

  const handleShowResult = (title) => {
    setTitle(title);
    console.log(title);
    setShowResult(false);
  };

  const handle1 = async (id) => {
    setShowResult(false);

    setShowDancingClub(true);
    setCompetitionDancers(false);

    try {
      const response = await axios.get(
        `http://localhost:8888/dancer/get_by_club.php?title=${id}`
      );
      console.log(response.data);
      setData(response.data.message ? [{ error: "No data" }] : response.data);
      setData2(response.data);
    } catch (error) {
      console.error(error);
    }
  };
  const handle2 = async () => {
    console.log(title);
    setShowResult(false);
    setShowDancingClub(true);
    setCompetitionDancers(true);
    setCompetitionDancersData([{ message: "Нема танцівників" }]);

    try {
      const response = await axios.get(
        `http://localhost:8888/couples/get_by_comp.php?title=${title}`
      );

      console.log(response.data);
      setCompetitionDancersData(
        response.data.message ? [{ error: "No data" }] : response.data
      );
    } catch (error) {
      setCompetitionDancersData([{ message: "Нема танцівників" }]);

      console.error(error);
    }
  };
  useEffect(() => {
    setCompetitionDancersData([{ message: "Нема танцівників" }]);

    handle2();
  }, [title]);

  const handleFetchFutureData = async () => {
    try {
      const response = await axios.get(
        `http://localhost:8888/comp_result/index.php`
      );

      setData1(response.data.message ? [{ error: "No data" }] : response.data);
    } catch (error) {
      console.error(error);
    }
  };
  const removeNumbers = data && data.map(({ id, coach_id, ...rest }) => rest);

  const [allData, setAllData] = useState([]);

  useEffect(() => {
    const fetchData = async () => {
      try {
        const response = await axios.get(
          "http://localhost:8888/comp/index.php"
        );
        setAllData(
          response.data.message ? [{ error: "No data" }] : response.data
        );
      } catch (error) {
        console.error(error);
      }
    };

    fetchData();
  }, []);
  const now = Date.now();

  const pastEvents = allData
    .filter((event) => {
      const eventDate = Date.parse(event.date);

      return eventDate < now;
    })
    .map(({ title, date, location, description }) => ({
      title,
      date,
      location,
      description,
    }));

  const futureEvents = allData
    .filter((event) => {
      const eventDate = Date.parse(event.date);
      return eventDate >= now;
    })
    .map(({ title, date, location, description, id }) => ({
      title,
      id,
      date,
      location,
      description,
    }));

  const [selectedTab, setSelectedTab] = useState(0);
  const [showAddition, setShowAddition] = useState(false);

  const handleFetchAllDancers = async () => {
    try {
      const response = await axios.get(
        `http://localhost:8888/dancer/get_by_coach.php?id=${userData?.coach_id}`
      );

      setData(response.data.message ? [{ error: "No data" }] : response.data);
    } catch (error) {
      console.error(error);
    }
  };

  const handleFetchAllEvents = async () => {
    try {
      const response = await axios.get(`http://localhost:8888/comp/index.php`);
      const filteredData = response.data.filter(
        (event) => event.organizator_id === userData?.table_id
      );
      console.log(filteredData);
      setData(filteredData);
    } catch (error) {
      console.error(error);
    }
  };

  const pastEventsO = data
    .filter((event) => {
      const eventDate = Date.parse(event.date);

      return eventDate < now;
    })
    .map(({ title, date, location }) => ({
      title,
      date,
      location,
    }));

  const futureEventsO = data
    .filter((event) => {
      const eventDate = Date.parse(event.date);
      return eventDate >= now;
    })
    .map(({ title, date, location }) => ({
      title,
      date,
      location,
    }));

  useEffect(() => {
    handleGetDancingData();
    handleFetchFutureData();
  }, []);

  const [competitionData, setCompetitionData] = useState([]);
  const handlerDownloadCSV = async () => {
    fetch("http://localhost:8888/comp_result/index.php")
      .then((response) => response.json())
      .then((data) => {
        setCompetitionData(data);
      })
      .catch((error) => {
        console.error("Error fetching data:", error);
      });
  };

  useEffect(() => {
    handlerDownloadCSV();
  }, [title]);

  const handleGetId = (title, id) => {
    setCompetitionId(id);
    setTitle(title.title);
    console.log(title);
  };

  const handleAddDancerClick = (n) => {
    setSelectedTab(n);
  };
  console.log(data);
  return (
    <Tabs
      className="container"
      selectedIndex={selectedTab || parseInt(id)}
      onSelect={(index) => setSelectedTab(index)}
    >
      <div className="tabs-header">
        <TabList style={customStyles.tabList}>
          {[
            {
              label: "Головна сторінка",
              onClick: () => navigate("/"),
            },
            {
              label: "Танцювальні клуби",
              onClick: () => {
                closeTab();
                handleGetDancingData();
              },
            },
            {
              label: "Змагання",
              onClick: () => {
                closeTab();
                handleFetchFutureData();
                setCompetitionDancersData([{ message: "Нема танцівників" }]);
              },
            },
            // {
            //   label: "Танцівники",
            //   onClick: closeTab,
            // },
            {
              label: "Створити змагання",
              onClick: closeTab,
              isVisible: userData?.role === "organizator",
            },
            {
              label: "Мої змагання",
              onClick: () => {
                closeTab();
                handleFetchAllEvents();
              },
              isVisible: userData?.role === "organizator",
            },
            {
              label: "Додати танцівника",
              onClick: () => {
                closeTab();
                setShowAddition(true);
              },
              isVisible: userData?.role === "coach",
            },
            {
              label: "Мої танцівники",
              onClick: () => {
                closeTab();
                handleFetchAllDancers();
              },
              isVisible: userData?.role === "coach",
            },
          ].map(
            ({ label, onClick, isVisible }, index) =>
              (isVisible ?? true) && (
                <Tab
                  className="selectedTab"
                  key={index}
                  index={index}
                  onClick={onClick}
                >
                  {label}
                </Tab>
              )
          )}
        </TabList>
        {!userData?.role && (
          <button className="login-btn" onClick={() => navigate("/login")}>
            Увійти
          </button>
        )}
      </div>

      {displayResult ? (
        <>
          <TabPanel index={0}>
            <TableTemplate
              data={[
                {
                  genre: "Modern",
                  location: "Lviv",
                  instructor: "Kanata Igor",
                },
                {
                  genre: "Hip-hop",
                  location: "Kyiv",
                  instructor: "Petrenko Maria",
                },
                {
                  genre: "Jazz",
                  location: "Odessa",
                  instructor: "Sidorov Ivan",
                },
              ]}
              headers={["Dance genre"]}
            />
          </TabPanel>
          <TabPanel index={1}>
            <TableTemplate
              data={removeNumbers}
              linksTitle="Переглянути танцівників"
              headers={["Танцювальні клуби"]}
              links={true}
              onClick={handle1}
            />
          </TabPanel>
          <TabPanel index={2}>
            <Tabs>
              <TabList style={customStyles.tabList} className="inner-list">
                <Tab className="selected-mini-tab">Майбутні змагання</Tab>
                <Tab className="selected-mini-tab">Проведені змагання</Tab>
              </TabList>

              <TabPanel index={0}>
                <TableTemplate
                  data={futureEvents}
                  linksTitle="Переглянути танцівників"
                  additionalLink="Зареєструватись"
                  links={true}
                  onClick={handle2}
                  onAdditionalLinkClick={() => {
                    setShowAddition(false);
                    handleAddDancerClick(3);
                  }}
                  handleShowResultIs={true}
                  handleShowResult={handleGetId}
                />
              </TabPanel>
              <TabPanel index={1}>
                <TableTemplate
                  data={pastEvents}
                  linksTitle="Результати"
                  onClickIs={false}
                  handleShowResult={handleShowResult}
                />
              </TabPanel>
            </Tabs>
          </TabPanel>
          {/* <TabPanel index={3}>
            <h2>Content for Tab 4</h2>
            <p>Here's some content for Tab 4.</p>
          </TabPanel> */}
          {userData?.role === "organizator" ? (
            <>
              <TabPanel index={4}>
                <CreateEventOrginizer />
              </TabPanel>
              <TabPanel index={65}>
                <Tabs>
                  <TabList style={customStyles.tabList} className="inner-list">
                    <Tab className="selected-mini-tab">Майбутні змагання</Tab>
                    <Tab className="selected-mini-tab">Проведені змагання</Tab>
                  </TabList>

                  <TabPanel index={0}>
                    <TableTemplate data={futureEventsO} links={false} />
                  </TabPanel>
                  <TabPanel index={1}>
                    <TableTemplate
                      data={pastEventsO}
                      linksTitle="Завантажити"
                      handleShowResultIs={true}
                      // onClick={handleShowResult}
                      handleShowResult={handleGetId}
                      onClick={() => {
                        downloadCSV(competitionData, title);
                      }}
                    />
                  </TabPanel>
                </Tabs>
              </TabPanel>
            </>
          ) : null}
          {userData?.role === "coach" ? (
            <>
              <TabPanel index={4}>
                {showAddition ? (
                  <CreateEvent />
                ) : (
                  <RegisterUser competitionId={competitionId} />
                )}
              </TabPanel>
              <TabPanel index={5}>
                <TableTemplate
                  data={data.map((obj) => {
                    const { coach_id, ...rest } = obj;
                    return rest;
                  })}
                  headers={["Танцівники клубу"]}
                />
              </TabPanel>
            </>
          ) : null}
        </>
      ) : (
        <>
          {showDancingClub ? (
            <TableTemplate
              data={
                !competitionDancers
                  ? data.map(({ coach_id, coach_full_name, ...res }) => res)
                  : competitionDancersData
              }
              headers={
                competitionDancers
                  ? ["Танцювальні клуби"]
                  : ["Танцівники клубу"]
              }
            />
          ) : (
            <PageResult title={title} data={data} />
          )}
        </>
      )}
    </Tabs>
  );
};

export default TabsPanel;
