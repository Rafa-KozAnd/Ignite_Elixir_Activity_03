defmodule Rockelivery.Orders.ReportRunner do
  @moduledoc """
  Módulo que executa a geração de relatórios pelo GenServer
  """
  use GenServer
  require Logger
  alias Rockelivery.Orders.Report

  def start_link(_initial_state) do
    GenServer.start_link(__MODULE__, %{})
  end

  @impl true
  def init(state) do
    Logger.info("ReportRunner started!")
    schedule_report_generation()
    {:ok, state}
  end

  @impl true
  def handle_info(:generate, state) do
    Logger.info("Generating Report...")
    Report.create()

    # depois de executar o relatório, agenda novamente
    schedule_report_generation()
    {:noreply, state}
  end

  def schedule_report_generation do
    Process.send_after(self(), :generate, 1000 * 60)
  end
end
