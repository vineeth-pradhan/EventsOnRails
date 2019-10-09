import React from 'react';
import './App.css';
import EventsContent from './DomContent/EventsContent';
import UsersContent from './DomContent/UsersContent';

class App extends React.Component {
  constructor() {
    super();
    this.state = { users: [], events: [], eventsUrl: 'http://localhost:3000/events.json', usersUrl: 'http://localhost:3000/users.json' };
    this.handleEventsChange = this.handleEventsChange.bind(this);
    // this.handleUsersChange = this.handleUsersChange.bind(this);
  }

  handleMenuClick(e, type) {
    this.toggleActive(e, type);
    this.loadContent(type);
  }

  fetchEvents(){
    fetch(this.state.eventsUrl)
      .then(res => { return res.json(); })
      .then(res => { this.setState({ events: res, currentSelectedMenu: 'events' }) })
      .catch(err => { console.log('Something went wrong') });
  }

  fetchUsers(){
    fetch(this.state.usersUrl)
      .then(res => { return res.json(); })
      .then(res => { this.setState({ users: res, currentSelectedMenu: 'users' }) })
      .catch(err => { alert('Something went wrong') });
  }

  async handleEventsChange(obj){
    var newEventsUrl = this.state.eventsUrl;
    newEventsUrl += obj.date;
    await this.setState({ eventsUrl: newEventsUrl });
  }

  loadContent(type) {
    switch(type) {
      case 'events':
        this.fetchEvents();
        break;
      case 'users':
        this.fetchUsers();
        break;
      default:
        break;
    }
  }

  toggleActive(e, type) {
    // console.log(e.target.id === type);
    var cL = document.querySelector('a.is-active');
    if(cL){
      document.querySelector('a.is-active').classList.remove('is-active');
    }
    e.target.classList.add('is-active');
  }

  render() {
    var currentDom;
    if(this.state.currentSelectedMenu === 'events') { currentDom = <EventsContent data={ this.state.events } onChange={this.handleEventsChange} /> }
    else if(this.state.currentSelectedMenu === 'users'){ currentDom = <UsersContent data={ this.state.users } /> }

    return (
      <div className="App">
        <div className="columns dashboard">
          <div className="column is-one-fifth left-menu">
            <aside>
              <p className="menu-label">
                General
              </p>
              <ul className="menu-list">
                <li><a id='events' onClick={ (e) => { this.handleMenuClick(e, 'events') } }>Events</a></li>
                <li><a id='users' onClick={ (e) => { this.handleMenuClick(e, 'users') } }>Users</a></li>
              </ul>
            </aside>
          </div>
          <div className="column is-two-thirds dom-content">
            { currentDom }
          </div>
        </div>
      </div>
    );
  }
}

export default App;
