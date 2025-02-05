### A Pluto.jl notebook ###
# v0.19.46

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    quote
        local iv = try Base.loaded_modules[Base.PkgId(Base.UUID("6e696c72-6542-2067-7265-42206c756150"), "AbstractPlutoDingetjes")].Bonds.initial_value catch; b -> missing; end
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : iv(el)
        el
    end
end

# ╔═╡ 07ebdbbe-49bb-4d18-9f2b-14f98d137548
begin
	using Pkg
	Pkg.activate(temp=true)
	Pkg.develop(path=dirname(@__DIR__))
	Pkg.add("Deno_jll")
	
	using PlutoMonacoEditor: MonacoEditor
	using Deno_jll
end

# ╔═╡ 9aa40f8c-a955-47a3-8e6d-4ac54d1dc330
md"""
# TypeScript Editor on Pluto Notebook

Here we use Deno as a TypeScript runtime.

What is deno? ↓↓↓

> Deno (/ˈdiːnoʊ/, pronounced dee-no) is an open source JavaScript, TypeScript, and WebAssembly runtime with secure defaults and a great developer experience. It's built on V8, Rust, and Tokio.
>
> https://docs.deno.com/runtime/#install-deno
"""

# ╔═╡ bf232d99-3001-4aac-afb7-1321c7407666
begin
	initCode = raw"""
function greet(name: string): string {
  return `Hello, ${name}!`;
}

console.log(greet("world"));
"""
	@bind sourcecode MonacoEditor("typescript", initCode, width=700, height=200)
end

# ╔═╡ dce616d7-fdfe-4854-919d-420603ebc875
mktempdir() do d
	sourcepath = joinpath(d, "main.ts")
	tsruntime = `$(deno()) run`
	open(sourcepath, "w") do io
		write(io, sourcecode)
	end	
	executablepath = joinpath(d, "main")
	run(`$(tsruntime) $(sourcepath)`)
end

# ╔═╡ Cell order:
# ╟─9aa40f8c-a955-47a3-8e6d-4ac54d1dc330
# ╠═07ebdbbe-49bb-4d18-9f2b-14f98d137548
# ╟─bf232d99-3001-4aac-afb7-1321c7407666
# ╠═dce616d7-fdfe-4854-919d-420603ebc875
