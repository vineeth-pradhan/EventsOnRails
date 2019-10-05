import React from 'react';

function EventsContent(props){
  var tBody = [];
  props.data.forEach(datum => {
    tBody.push(<tr><td> { datum.title } </td><td> { datum.description } </td><td> { datum.starttime } </td><td> { datum.endtime } </td><td> { datum.allday ? "True" : "False" } </td></tr>)
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
        { tBody }
      </tbody>
    </table>
  )
}

export default EventsContent;
