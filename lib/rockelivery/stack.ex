defmodule Rockelivery.Stack do
  @moduledoc """
    Módulo de exemplo do funcionamento de um GEnServer

  """
  # esse use trás o behaviour do GenServer
  use GenServer

  # Cliente

  def start_link(initial_stack) when is_list(initial_stack) do
    GenServer.start_link(__MODULE__, initial_stack)
  end

  def push(pid, element) do
    GenServer.cast(pid, {:push, element})
  end

  def pop(pid) do
    GenServer.call(pid, :pop)
  end

  # SERVER 
  # defini o estado inicial do genserver 
  # impl true não tem efeito prática, mas deixa explicito que é uma implmentação, além de forçar 
  # o compilador a verificar a assinatura do método
  @impl true
  def init(stack) do
    {:ok, stack}
  end

  # sincrono
  @impl true
  def handle_call({:push, element}, _from, state) do
    # sempre devemos devolver um reply (resposta), o retorno que quisermos, e o estado atualizado do genserver.
    new_stack = [element | state]
    {:reply, new_stack, new_stack}
  end

  @impl true
  def handle_call(:pop, _from, [head | tail]) do
    {:reply, head, tail}
  end

  # assincrono
  @impl true
  def handle_cast({:push, element}, stack) do
    {:noreply, [element | stack]}
  end
end
