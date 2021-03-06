% RSKELFR_SVD  Solve by D factor in rectangular recursive skeletonization
%              factorization F = L*D*U.
%
%    See also RSKELFR, RSKELFR_SV.

function Y = rskelfr_svd(F,X,trans)

  % set default parameters
  if nargin < 3 || isempty(trans)
    trans = 'n';
  end

  % check inputs
  assert(strcmpi(trans,'n') || strcmpi(trans,'c'), ...
         'FLAM:rskelfr_svd:invalidTrans', ...
         'Transpose parameter must be either ''N'' or ''C''.')

  % initialize
  n = F.lvp(end);

  % no transpose
  if strcmpi(trans,'n')
    Y = zeros(F.N,size(X,2));
    for i = 1:n
      rrd = F.factors(i).rrd;
      crd = F.factors(i).crd;
      nrrd = length(rrd);
      ncrd = length(crd);
      if nrrd > ncrd
        Y(crd,:) = F.factors(i).L'*X(rrd,:);
      elseif nrrd < ncrd
        Y(crd,:) = F.factors(i).U'*X(rrd,:);
      else
        Y(crd,:) = X(rrd,:);
      end
    end

  % conjugate transpose
  else
    Y = zeros(F.M,size(X,2));
    for i = 1:n
      rrd = F.factors(i).rrd;
      crd = F.factors(i).crd;
      nrrd = length(rrd);
      ncrd = length(crd);
      if nrrd > ncrd
        Y(rrd,:) = F.factors(i).L*X(crd,:);
      elseif nrrd < ncrd
        Y(rrd,:) = F.factors(i).U*X(crd,:);
      else
        Y(rrd,:) = X(crd,:);
      end
    end
  end
end