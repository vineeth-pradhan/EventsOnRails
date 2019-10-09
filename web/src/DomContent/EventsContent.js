import React from 'react';
import DatePicker from "react-datepicker";
import "react-datepicker/dist/react-datepicker.css";

class EventsContent extends React.Component {
  constructor(props){
    super(props);
    this.state = { from: '',  to: '' };
    this.handleStartDateFilterChange = this.handleStartDateFilterChange.bind(this);
    this.handleEndDateFilterChange = this.handleEndDateFilterChange.bind(this);
  }

  async handleStartDateFilterChange(date){
    await this.populateStartDate(date);
    console.log(this.state.from);
  }

  async handleEndDateFilterChange(date){
    await this.populateEndDate(date);
    this.props.onChange(date);
  }

  populateStartDate(date){ this.setState({ from: date }); }

  populateEndDate(date){ this.setState({ to: date }); }

  render() {
    var tBody = [];
    this.props.data.forEach((datum, index) => {
      tBody.push(<tr key={index}><td> { datum.title } </td><td> { datum.description } </td><td> { datum.starttime } </td><td> { datum.endtime } </td><td> { datum.allday ? "True" : "False" } </td></tr>)
    });

    return(
      <table className='table is-bordered is-striped is-hoverable is-fullwidth'>
        <thead>
          <tr>
            <th> Title </th>
            <th> Description  </th>
            <th> Start Time </th>
            <th> End Time </th>
            <th> All Day? </th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td></td>
            <td></td>
            <td><DatePicker selected={this.state.from} onChange={this.handleStartDateFilterChange} /></td>
            <td><DatePicker selected={this.state.to} onChange={this.handleEndDateFilterChange} /></td>
            <td></td>
          </tr>
          { tBody }
        </tbody>
      </table>
    )
  }
}

export default EventsContent;
