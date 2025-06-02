defmodule ObservabilityWeb.MetricsLive do
  use ObservabilityWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, metric_stream: false)}
  end

  @impl true
  def handle_event("trigger_metric", _params, socket) do
    {:noreply,
     socket
     |> put_flash(:info, "Metric triggered successfully!")}
  end

  @impl true
  def handle_event("toggle_metric_stream", _params, socket) do
    current_state = socket.assigns.metric_stream
    new_state = !current_state

    message = if new_state, do: "Metric stream started!", else: "Metric stream stopped!"

    {:noreply,
     socket
     |> assign(metric_stream: new_state)
     |> put_flash(:info, message)}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div class="min-h-screen bg-gradient-to-b from-indigo-100 to-white">
      <div class="container mx-auto px-6 py-8">
        <div class="text-center mb-12">
          <h2 class="text-3xl font-semibold text-indigo-600">Metrics Pillar</h2>
          <div class="w-24 h-1 bg-indigo-500 mx-auto mt-4 mb-6"></div>
          <p class="text-gray-600 max-w-2xl mx-auto">
            Trigger metrics with the buttons below
          </p>
        </div>

        <div class="bg-white rounded-xl shadow-lg p-8 mb-10 max-w-4xl mx-auto">
          <div class="flex flex-col space-y-6 md:flex-row md:space-y-0 md:space-x-6 md:justify-center">
            <.button
              phx-click="trigger_metric"
              class="!bg-indigo-600 !hover:bg-indigo-700 text-lg py-3 px-6 rounded-lg shadow-md transition-all duration-300 transform hover:scale-105"
            >
              Trigger Metric
            </.button>

            <.button
              phx-click="toggle_metric_stream"
              class={
                if @metric_stream do
                  "flex items-center justify-center !bg-rose-600 !hover:bg-rose-700 text-lg py-3 px-6 rounded-lg shadow-md transition-all duration-300 transform hover:scale-105"
                else
                  "flex items-center justify-center !bg-emerald-600 !hover:bg-emerald-700 text-lg py-3 px-6 rounded-lg shadow-md transition-all duration-300 transform hover:scale-105"
                end
              }
            >
              <span class="mr-2">
                <%= if @metric_stream, do: "Stop", else: "Start" %> Metric Stream
              </span>
              <.icon name={if @metric_stream, do: "hero-stop-solid", else: "hero-play-solid"} class="h-5 w-5" />
            </.button>
          </div>
        </div>

        <div class="bg-white rounded-xl shadow-lg p-8 max-w-4xl mx-auto">
          <h2 class="text-2xl font-semibold text-indigo-700 mb-6 border-b border-indigo-100 pb-3">Metrics Status</h2>
          <div class="flex items-center justify-between p-4 bg-gray-50 rounded-lg">
            <div class="flex items-center">
              <div class={
                if @metric_stream do
                  "w-4 h-4 rounded-full bg-emerald-500 mr-3 animate-pulse"
                else
                  "w-4 h-4 rounded-full bg-gray-400 mr-3"
                end
              }></div>
              <span class="text-gray-700 font-medium">Metric Stream:</span>
            </div>
            <span class={
              if @metric_stream do
                "font-bold text-emerald-600 text-lg"
              else
                "font-bold text-gray-600 text-lg"
              end
            }>
              <%= if @metric_stream, do: "Running", else: "Stopped" %>
            </span>
          </div>
        </div>
      </div>
    </div>
    """
  end
end
