@foreach($events as $event)
    <h2>Event {{ $event->name }}</h2>
    <p>{{ $event }}</p>
@endforeach