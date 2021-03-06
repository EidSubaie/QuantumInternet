import data.real.basic
import analysis.special_functions.exp_log
import _5_The_Physical_Layer.optical_fiber.quantum_channel
import _5_The_Physical_Layer.qubit_carriers.quantum_state
import common.matrix_ops

notation `|` x `|` := abs x

---- HOLEVO INFORMATION

/-
Definition (Holevo information of a quantum channel)
"The Holevo information Ο(π©) of a channel π© is a measure 
of the classical correlations that Alice can establish
with Bob where the maximization is with respect to all 
input classicalβquantum states."
https://arxiv.org/pdf/1106.1445.pdf
-/
def Holevo_info (π© : quantum_channel) : β := 
begin
    -- the set of all classical-quantum states
    let CQ_states := {Ο : density_operator | is_classical_quantum(Ο)},
    -- the states after the channel acts on Bob's system
    let output_states := {Iβπ© Ο | Ο β CQ_states}
    -- the set of all values of mutual information for the output states
    let I_out := {I(X;B)_Ο | Ο β CQ_states},
    -- let maximum be a real number
    let maximum : β := _,
    -- the maximum is in I_CQ
    let h := maximum β I_out,
    -- the maximum is at least as big as any element in I_CQ
    let h' := β x β I_out, maximum β₯ x,
    -- Holevo info is the maximum
    exact maximum,
end

notation `Ο(` π© `)` := Holevo_info π©

/-
Definition (regularized Holevo information of a quantum channel)
-/
def reg_Holevo_info (π© : quantum_channel) : β := 
begin
    -- let lim be a real number
    let lim : β := _,
    -- let the Holevo information of many uses of the channel 
    -- tend to this limit lim.
    let h := β Ξ΅ > 0, β N, β n > N, |lim - Ο(π©β..n..βπ©)| β€ Ξ΅,
    -- the regularized Holevo information is this limit
    exact lim,
end

notation `Ο_reg(` Ο `)` := reg_Holevo_info π©

/-
Theorem (Holevo information of entanglement-breaking channels)
-/
theorem Holevo_info_eq_reg_Holevo_info_of_entanglement_breaking {π© : quantum_channel} :
is_entanglement_breaking(π©) β Ο(π©) = Ο_reg(π©) := 
begin
    sorry
end




---- SQUASHED ENTANGLEMENT

/-
Definition (squashed entanglement of a quantum channel)
-/
def squashed_entanglement (π© : quantum_channel) : β := 
maximum_Ο squashed_entanglement(Ο)

/-
Theorem (upper bound on squashed entanglement of 
phase-insensisitve Gaussian quantum channels)
https://arxiv.org/pdf/1511.08710.pdf
-/
notation `ΞΆ(` a `,` b `)` := a * b * real.log(a/b)

theorem squashed_entanglement_phase_insensitive_channels_up_bound
{π© : phase_insensitive_channel} : 
squashed_entanglement(π©) β€ 
    (ΞΆ(1 + π©.noise + 3*π©.gain, 1 + π©.noise - π©.gain) - π©.gain * ΞΆ(π©.gain + π©.noise + 3, π©.gain + π©.noise - 1)) / (2 * (1 + π©.noise + π©.gain) * (1 - π©.gain^2)) :=
begin
    sorry
end




---- MUTUAL INFORMATION

/-
Definition (mutual information of a quantum channel)
"The mutual information of a quantum channel corresponds 
to an important operational task that is not particularly 
obvious from the above discussion. Suppose that Alice and 
Bob share unlimited bipartite entanglement in whatever 
form they wish, and suppose they have access to a large 
number of independent uses of the channel NA0βB. Then the 
mutual information of the channel corresponds to the maximal 
amount of classical information that they can transmit in 
such a setting."
https://arxiv.org/pdf/1106.1445.pdf
-/
def mut_info (π© : quantum_channel) : β :=  
begin
    -- the set of all pure states
    let pure_states := {Ο : density_operator | is_pure(Ο)},
    -- the states after the channel acts on Bob's system
    let output_states := {Iβπ© Ο | Ο β pure_states}
    -- the set of all values of mutual information
    let I_out := {I(A;B)_Ο | Ο β pure_states},
    -- let maximum be a real number
    let maximum : β := _,
    -- the maximum is in I_CQ
    let h := maximum β I_pure,
    -- the maximum is at least as big as any element in I_CQ
    let h' := β x β I_out, maximum β₯ x,
    -- Holevo info is the maximum
    exact maximum,
end

notation `I(` π© `)` := mut_info π©

/-
Definition (regularized mutual information)
-/
def reg_mut_info (π© : quantum_channel) : β := 
begin
    -- let lim be a real number
    let lim : β := _,
    -- let the mutual information of many uses of the channel 
    -- tend to this limit lim.
    let h := β Ξ΅ > 0, β N, β n > N, |lim - I(π©β..n..βπ©)| β€ Ξ΅,
    -- the regularized private information is this limit
    exact lim,
end

notation `I_reg(` π© `)` := reg_mut_info π©

/-
Theorem (additivity)
-/
@[simp]
theorem mut_info_additive {π© : quantum_channel} {β³ : quantum_channel}: 
I(π©ββ³) = I(π©) + I(β³) :=
begin
    sorry
end

/-
Theorem (regularized mutual information = mutual information)
-/
theorem reg_mut_info_eq_mut_info {π© : quantum_channel} :
I_reg(π©) = I(π©) :=
begin
    sorry
end




---- COHERENT INFORMATION

/-
Definition (coherent information of a quantum channel)
"The coherent information of a quantum channel corresponds 
to an important operational task (perhaps the most important 
for quantum information). It is a good lower bound on the 
capacity for Alice to transmit quantum information to Bob, 
but it is actually equal to such a quantum communication 
capacity of a quantum channel in some special cases."
https://arxiv.org/pdf/1106.1445.pdf
-/
def coherent_info (π© : quantum_channel) : β := 
begin
    -- the set of all pure states
    let pure_states := {Ο : density_operator | is_pure(Ο)},
    -- the states after the channel acts on Bob's system
    let output_states := {Iβπ© Ο | Ο β pure_states}
    -- the set of all values of coherent information
    let I_out := {I(Aβ©B)_Ο | Ο β pure_states},
    -- let maximum be a real number
    let maximum : β := _,
    -- the maximum is in I_CQ
    let h := maximum β I_pure,
    -- the maximum is at least as big as any element in I_CQ
    let h' := β x β I_out, maximum β₯ x,
    -- Holevo info is the maximum
    exact maximum,
end

notation `Q(` π© `)` := coherent_info π©

/-
Definition (regularized coherent information)
-/
def reg_coherent_info (π© : quantum_channel) : β := 
begin
    -- let lim be a real number
    let lim : β := _,
    -- let the coherent information of many uses of the channel 
    -- tend to this limit lim.
    let h := β Ξ΅ > 0, β N, β n > N, |lim - Q(π©β..n..βπ©)| β€ Ξ΅,
    -- the regularized coherent information is this limit
    exact lim,
end

notation `Q_reg(` π© `)` := reg_coherent_info π©

/-
Theorem (non-negativity)
-/
theorem coherent_info_nonneg {π© : quantum_channel} : 
Q(π©) β₯ 0 := 
begin
    sorry
end




---- REVERSE COHERENT INFORMATION

/-
Definition (reverse coherent information)
-/
def reverse_coherent_info (π© : quantum_channel) : β := 
begin
    -- the set of all pure states
    let pure_states := {Ο : density_operator | is_pure(Ο)},
    -- the states after the channel acts on Bob's system
    let output_states := {Iβπ© Ο | Ο β pure_states}
    -- the set of all values of coherent information
    let I_out := {I(Bβ©A)_Ο | Ο β pure_states},
    -- let maximum be a real number
    let maximum : β := _,
    -- the maximum is in I_CQ
    let h := maximum β I_pure,
    -- the maximum is at least as big as any element in I_CQ
    let h' := β x β I_out, maximum β₯ x,
    -- Holevo info is the maximum
    exact maximum,
end

notation `Q_rev(` π© `)` := reverse_coherent_info π©




---- PRIVATE INFORMATION

/-
Definition (private information)
"Alice would like to establish classical correlations with Bob, 
but does not want the environment of the channel to have access 
to these classical correlations."
https://arxiv.org/pdf/1106.1445.pdf
-/
def private_info (π© : quantum_channel) : β := 
begin
    -- the set of all classical-quantum states
    let CQ_states := {Ο : density_operator | is_classical_quantum(Ο)},
    -- the states after the channel acts on Bob's system
    let output_states := {(isometric_extension π©) Ο | Ο β CQ_states}
    -- the set of all values of mutual information for the output states
    let I_out := {I(X;B)_Ο - I(X;E)_Ο | Ο β CQ_states},
    -- let maximum be a real number
    let maximum : β := _,
    -- the maximum is in I_CQ
    let h := maximum β I_out,
    -- the maximum is at least as big as any element in I_CQ
    let h' := β x β I_out, maximum β₯ x,
    -- Holevo info is the maximum
    exact maximum,
end

notation `P(` π© `)` := private_info π©

/-
Definition (regularized private information)
-/
def reg_private_info {Ξ΅ : β} (π© : quantum_channel) : β := 
begin
    -- let lim be a real number
    let lim : β := _,
    -- let the private information of many uses of the channel 
    -- tend to this limit lim.
    let h := β Ξ΅ > 0, β N, β n > N, |lim - P(π©β..n..βπ©)| β€ Ξ΅,
    -- the regularized private information is this limit
    exact lim,
end

notation `P_reg(` π© `)` := reg_private_info π©

/-
Theorem (private info β₯ coherent info for any channel)
-/
theorem private_info_geq_coherent_info :
β (π© : quantum_channel), P(π©) β₯ Q(π©) :=
begin
    sorry
end

/-
Theorem (private info is = coherent info for degradable channels)
-/
theorem private_info_eq_coherent_info_of_degradable : 
β (π© : quantum_channel), is_degradable(π©) β P(π©) = Q(π©) :=
begin
    sorry
end




-- QUANTUM CAPACITY

/-
Definition (quantum communication code)
-/
structure code : Type :=
(π© : quantum_channel) -- the channel the code is designed for
(n : β) -- uses of the channel
(Ξ΅ : β) -- allowed error
(β° : quantum_channel) -- encoding channel
(π : quantum_channel) -- decoding channel
-- output state is within allowed error for all input states
(hΞ΅ : β (Ο :  density_operator), 
    1/2 * β₯Ο - π(tensor_pow_channel π© n (β°(Ο)))β₯β β€ Ξ΅)
(rate_achieved : β := 1/n * log β°.in_dim) -- the rate of the code

/-
Definition (achievable rate using a channel)
-/
def is_achievable_rate (π© : quantum_channel) (rate : β) : Prop :=
β (Ξ΅ Ξ΄ : β) (hΞ΅ : Ξ΅ > 0 β§ Ξ΅ < 1) (hΞ΄ : Ξ΄ > 0), 
β (c : code), c.rate_achieved β₯ rate - Ξ΄ β§ c.Ξ΅ β€ Ξ΅

/-
Definition (quantum capacity of a quantum channel): supremum 
of all rates achievable using the channel. 
-/
def quantum_capacity (π© : quantum_channel) : β :=
begin
    let achievable_rates := {rate : β | is_achievable_rate π© rate},
    let bigger_rates := {rate : β | β ar β achievable_rates, rate > ar},
    let supremum_rate : β := _,
    let h_supremum_rate  : Prop := β rate β bigger_rates, supremum_rate β€ rate,
    let h_supremum_rate' : Prop := β rate β achievable_rates, supremum_rate > rate, 
    exact supremum_rate,
end

/-
Theorem (quantum capacity equals regularized coherent information)
https://arxiv.org/pdf/1106.1445.pdf
-/
theorem quantum_capacity_eq_reg_coh_info {π© : quantum_channel} : 
quantum_capacity(π©) = reg_coherent_info(π©) := 
begin
    sorry
end

/-
Theorem (quantum capacity of amp damp channel)
-/
theorem quantum_capacity_amp_damp {Ξ· : β} (π© := amp_damp_channel Ξ·) : 
quantum_capacity(π©) = min_p hβ((1-Ξ·)*p) - hβ(Ξ·*p) := 
begin
    sorry
end




---- TWO-WAY QUANTUM CAPACITY

-- can you represent the unlimited classical communication 
-- as a list of bits of arbitrary length that Alice and Bob can 
-- send to each other?

-- can you think of the classical communication as transmission 
-- of qubits carrying only classical information through the 
-- identity channel? can you absorb the local gates in the 
-- LOCCs into the encoding channel?

/-
Defintion (two-way capacity): The quantum capacity of a channel 
if unlimited classical communication is allowed between the sender 
and the receiver.
-/
def two_way_quantum_capacity (π© : quantum_channel) : β := sorry




---- 

/-
Definition (Ο-stretching): 
-/
def sigma_stretching (π© : quantum_channel) := sorry

/-
Defintion (KL divergence): 
-/
def KL_divergence := sorry