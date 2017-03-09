@foreach($events as $event)
    <h2>Event {{ $event->event_name }}</h2>
    <p>{{ $event }}</p>
@endforeach